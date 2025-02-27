package persistance.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import persistance.annotation.Colonne;
import persistance.annotation.NoMap;
import persistance.annotation.Table;
import persistance.database.Column;
import persistance.database.DBColumn;
import persistance.exception.MismatchException;

public class DBUtil {

    public static String getTableName(Object obj) {
        Class<?> clazz = obj.getClass();
        if (clazz.isAnnotationPresent(Table.class)) {
            Table annotation = clazz.getAnnotation(Table.class);
            if (!annotation.nom().equals("")) {
                return annotation.nom();
            }
            return clazz.getSimpleName().toLowerCase();
        }
        return null;
    }

    public static String getTableName(Class<?> clazz) {
        if (clazz.isAnnotationPresent(Table.class)) {
            Table annotation = clazz.getAnnotation(Table.class);
            if (!annotation.nom().equals("")) {
                return annotation.nom();
            }
            return clazz.getSimpleName().toLowerCase();
        }
        return null;
    }

    public static List<Column> getColumns(Object obj) {
        List<Column> columns = new ArrayList<>();
        Class<?> clazz = obj.getClass();
        Field[] fields = clazz.getDeclaredFields();

        for (Field field : fields) {
            field.setAccessible(true);
            if (field.isAnnotationPresent(NoMap.class)) {
                continue;
            }
            Column column = new Column();
            column.setNomColonneClasse(field.getName());
            if (field.isAnnotationPresent(Colonne.class)) {
                Colonne col = field.getAnnotation(Colonne.class);
                column.setNomColonneBase(col.value());
            } 
            else column.setNomColonneBase(field.getName().toLowerCase());
            column.setTypeColonne(field.getType().getSimpleName());
            columns.add(column);
        }

        return columns;
    }

    public static List<Column> getColumns(Class<?> clazz) {
        List<Column> columns = new ArrayList<>();
        Field[] fields = clazz.getDeclaredFields();

        for (Field field : fields) {
            field.setAccessible(true);
            if (field.isAnnotationPresent(NoMap.class)) {
                continue;
            }
            Column column = new Column();
            column.setNomColonneClasse(field.getName());
            if (field.isAnnotationPresent(Colonne.class)) {
                Colonne col = field.getAnnotation(Colonne.class);
                column.setNomColonneBase(col.value());
            } 
            else column.setNomColonneBase(field.getName().toLowerCase());
            column.setTypeColonne(field.getType().getSimpleName());
            columns.add(column);
        }

        return columns;
    }

    public static boolean verifyColumns(List<Column> colonneClasse, List<DBColumn> colonneBase)
            throws MismatchException {
        if (colonneBase.size() != colonneClasse.size()) {
            throw new MismatchException("nombre de colonnes invalide");
        }
        
        Set<String> baseColumnNames = colonneBase.stream()
                .map(DBColumn::getNomColonne)
                .collect(Collectors.toSet());

        for (Column colonne : colonneClasse) {
            if (!baseColumnNames.contains(colonne.getNomColonneBase())) {
                throw new MismatchException("La colonne '" + colonne.getNomColonneBase() + "' est absente dans la base de données.");
            }
        }

        return true;
    }

    public static String getNextSequenceValue(String sequenceName, Connection con) throws SQLException {
        String sql = "SELECT nextval('" + sequenceName + "')";
        try (PreparedStatement stmt = con.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return String.valueOf(rs.getInt(1));
            } else {
                throw new SQLException("La sequence n'existe pas");
            }
        }
    }

    public static void preparePK(Object obj, Connection con) throws NoSuchMethodException, SecurityException,
            IllegalAccessException, IllegalArgumentException, InvocationTargetException, SQLException {
        Class<?> clazz = obj.getClass();
        if (clazz.isAnnotationPresent(Table.class)) {
            Table annotation = clazz.getAnnotation(Table.class);
            Method met = clazz.getDeclaredMethod("setId", String.class);
            String prefix = annotation.prefixe();
            String sequenceName = "seq_" + getTableName(obj);
            String sequenceValue = getNextSequenceValue(sequenceName, con);
            String formattedId = prefix + String.format("%05d", Integer.parseInt(sequenceValue));
            met.invoke(obj, formattedId);
        }
    }

        public static Object getTransformedValue(ResultSet resultSet, Field field, String colBaseName) throws SQLException {
        try {
            Class<?> fieldType = field.getType();

            if (fieldType == String.class) {
                return resultSet.getString(colBaseName);
            } else if (fieldType == int.class || fieldType == Integer.class) {
                int value = resultSet.getInt(colBaseName);
                return resultSet.wasNull() ? null : value;
            } else if (fieldType == double.class || fieldType == Double.class) {
                double value = resultSet.getDouble(colBaseName);
                return resultSet.wasNull() ? null : value;
            } else if (fieldType == java.sql.Date.class) {
                return resultSet.getDate(colBaseName);
            } else if (fieldType == java.util.Date.class) {
                java.sql.Date sqlDate = resultSet.getDate(colBaseName);
                return sqlDate != null ? new java.util.Date(sqlDate.getTime()) : null; // Convert java.sql.Date to java.util.Date
            } else if (fieldType == long.class || fieldType == Long.class) {
                long value = resultSet.getLong(colBaseName);
                return resultSet.wasNull() ? null : value; // Handle long/Long
            } else if (fieldType == float.class || fieldType == Float.class) {
                float value = resultSet.getFloat(colBaseName);
                return resultSet.wasNull() ? null : value; // Handle float/Float
            } else if (fieldType == boolean.class || fieldType == Boolean.class) {
                boolean value = resultSet.getBoolean(colBaseName);
                return resultSet.wasNull() ? null : value; // Handle boolean/Boolean
            } else if (fieldType == BigDecimal.class) {
                return resultSet.getBigDecimal(colBaseName); // Handle BigDecimal
            } else if (fieldType == java.sql.Timestamp.class) {
                return resultSet.getTimestamp(colBaseName); // Handle Timestamp
            } else {
                return resultSet.getObject(colBaseName);
            }
        } catch (SQLException e) {
            throw new SQLException("Error retrieving value for column: " + colBaseName, e);
        }
    }



}
