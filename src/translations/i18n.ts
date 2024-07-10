import { initReactI18next } from 'react-i18next';
import * as RNLocalize from 'react-native-localize';

import i18n from 'i18next';

import { setLanguage } from '_stores/localeLanguage/LocaleLanguageSlice';
import { store } from '_stores/store';

import { LocaleLanguage } from '_utils/enums';

import { en } from './languages/en';
import { gu } from './languages/gu';
import { hi } from './languages/hi';
import { ka } from './languages/ka';
import { ma } from './languages/ma';
import { ta } from './languages/ta';
import { te } from './languages/te';

const locale = RNLocalize.getLocales()[0].languageCode;
i18n.language = locale;
if (locale?.includes(LocaleLanguage.En)) {
  store.dispatch(setLanguage(LocaleLanguage.En));
}
// Initialize i18n instance with different languages resources
export default i18n
  .use(initReactI18next)
  .init({
    compatibilityJSON: 'v3',
    resources: {
      en: {
        translation: en
      },
      hi: {
        translation: hi
      },
      gu: {
        translation: gu
      },
      ka: {
        translation: ka
      },
      ma: {
        translation: ma
      },
      ta: {
        translation: ta
      },
      te: {
        translation: te
      }
    },
    fallbackLng: locale,

    interpolation: {
      escapeValue: false
    }
  })
  .catch(() => {});

/**
 * Returns the localized string defined in language files.
 * @param name the complete path to string key => Exp: actions.continue
 * @param params Custom json params if needed to inject custom data into strings.
 * @returns - Returns translated string based on name and params (from languages fi les)
 */
export function strings(name: TxKeyPath, params = {}): string {
  return i18n.t(name, params);
}

export const ENGLISH_LANGUAGE = 'en';
export const HINDI_LANGUAGE = 'hi';
export const GUJARATI_LANGUAGE = 'en';
export const MARATHI_LANGUAGE = 'en';
export const KANNADA_LANGUAGE = 'en';
export const TAMIL_LANGUAGE = 'en';
export const TELUGU_LANGUAGE = 'en';

/**
 * Builds up valid keypaths for translations.
 */
export type TxKeyPath = RecursiveKeyOf<any>;
type RecursiveKeyOf<TObj extends object> = {
  [TKey in keyof TObj & (string | number)]: RecursiveKeyOfHandleValue<
    TObj[TKey],
    `${TKey}`
  >;
}[keyof TObj & (string | number)];
type RecursiveKeyOfInner<TObj extends object> = {
  [TKey in keyof TObj & (string | number)]: RecursiveKeyOfHandleValue<
    TObj[TKey],
    `['${TKey}']` | `.${TKey}`
  >;
}[keyof TObj & (string | number)];
type RecursiveKeyOfHandleValue<
  TValue,
  Text extends string
> = TValue extends any[]
  ? Text
  : TValue extends object
  ? Text | `${Text}${RecursiveKeyOfInner<TValue>}`
  : Text;
