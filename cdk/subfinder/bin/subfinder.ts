#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { SubfinderStack } from '../lib/subfinder-stack';

const app = new cdk.App();
new SubfinderStack(app, 'SubfinderStack');
