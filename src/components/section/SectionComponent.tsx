import { View, Text, useColorScheme, StyleSheet } from 'react-native';
import React, { PropsWithChildren } from 'react';
import { Colors } from 'react-native/Libraries/NewAppScreen';
import Config from 'react-native-config';
import { Image } from 'react-native';

type SectionProps = PropsWithChildren<{
  title: string;
}>;
function SectionComponent({
  children,
  title
}: SectionProps): React.JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <View style={styles.sectionContainer}>
      <Text
        style={[
          styles.sectionTitle,
          {
            color: isDarkMode ? Colors.white : Colors.black
          }
        ]}>
        {title} - {Config.ENV}
      </Text>
      <Text
        style={[
          styles.sectionDescription,
          {
            color: isDarkMode ? Colors.light : Colors.dark
          }
        ]}>
        {children}
      </Text>
    </View>
  );
}
// TODO - remove unused form eslint config file

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600'
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400'
  }
});

export default SectionComponent;
