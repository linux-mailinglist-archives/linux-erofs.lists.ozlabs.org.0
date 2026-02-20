Return-Path: <linux-erofs+bounces-2340-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMEDILfYmGnlNQMAu9opvQ
	(envelope-from <linux-erofs+bounces-2340-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Feb 2026 22:57:11 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7726416B148
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Feb 2026 22:57:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHkcK53w9z2xGF;
	Sat, 21 Feb 2026 08:57:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:d107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771624625;
	cv=pass; b=WXrL3nq4UrvoHfNo6PCrMW1jsZY0x6vlJgR/Y/TZlxZBdqsA97RvK6qcOLU314XOB0RtOD+3tNGnH0twq2KUJeqw38bwEzv34Tk7KbTIwIoFk4oHifdSx+8I74HaVG2AqqCEEjoi4nznRXpkPMCAd+iD605abp4CbOGtcC+ftaVrSVd9MmdILAnsINLMfzTRvoD8SKWqJo+hH3ZNZW4HZ8tb/IDKiZebBHhh2bkswhffNVvFCweVHBIXQ4BlipJQqS4UEfuXVqjCeewqTe7ZRdccztAh9gF7n25ThIDwbB0hrUnvw2yGgEAd+OubozHQMrd05SCAhRomOYvUjrqiGA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771624625; c=relaxed/relaxed;
	bh=kxn9ZzTJM0EaU0T07ytc/HW8d9BH3Ln+HYhNZV463h8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q8R4Qac4nP5x99vRR2YB9FjgMervSYF5wrqLpV2Cfyjh1tQS/TXXck5WABdn2BTkN/+LiKSUFyEV/rCN6w2ZpMtmFAu5y9RE0re1Ilnfuf49ijWsyc17WPwn6WcLupgBMmTG0PCF+u8/ItDNPd5qByev6cPXACeAngL0K+5aorluADaMYfDvN/ws6TJ6d1+9RaPGJikFBlAZLwX7j0q7PbGpZn80TLzG/hojyGtSf8Zmu2+Y+bY1v7hIhfU5GVragk+tNlrVNLDm4DWWyoFfKSDiuj5/o5rWg8e7CfenZZ1TwlapMngMiHS3I7lDPzYtSglNbW9ihsqhsTX8lMA3xg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=BFNoJyQZ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d107::1; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=aisclodagh90@hotmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=hotmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=BFNoJyQZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hotmail.com (client-ip=2a01:111:f403:d107::1; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=aisclodagh90@hotmail.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn190110001.outbound.protection.outlook.com [IPv6:2a01:111:f403:d107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHkcJ1v4Pz2xC3
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Feb 2026 08:57:03 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXK8y83Dqn9r5bSRbzWDjtJ5Vxae+5K6y3yB5DOYLwgmzggnoioK9Df11q0NT6ogiGEcLggMSsFeFHjb9YIAGE4qjuz+rg0Lf76sGl+XCg3XOcjiTDtdmHfwcMQPEQD60XLnmevf+K4ENPcmocsh8Tu2aZDgF/ESKwAozlezwhlmtQ/Je5fc3Xnx25AO0uJM73RnTFv7w2uV6yvVoasnxcLP1+mR9l2q8HHq08s3cFXMAlXY+fCR8adpjW9p4VJBiCtc6De07M+n03HzjWpOBCllIpBGEUKAHF1bJSVDYDYp2fg1JTt6+ukLmoyRrJzOwwLyBog114S+LahdghDh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxn9ZzTJM0EaU0T07ytc/HW8d9BH3Ln+HYhNZV463h8=;
 b=BlODDKTprXYJeu59ol7wRnVBV5r4yGzfXBkHXUGToAswIc65J/KLnPxGkQpkDCYGImN8NCP4nA4SPPaI2fH+0T7VTk0RJNX9/cGyUm71d+xpctAhGk75ZxQ6aWAefygQ7veu9+vX6LVsyLmD4iwz17+Jl42fLYUYgXL4WQy0a0ob5/7NKiroTQ5kCXrJd3PIK1Pk1+vkPS6//12UAsEx+3WYMQP2lySTyI9KUkO13VWV1bqBeG5a50ShncgDOcCrHOit8iGS3R/IfsvQdm7onqZZkPPDIFNFbVhscHvdj72oOtWM0/ILg0ILXglw2g7rUNCmcgVlSwlBxfqesco3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxn9ZzTJM0EaU0T07ytc/HW8d9BH3Ln+HYhNZV463h8=;
 b=BFNoJyQZqwKPFeIMj38rPlnUw+71wv4UHMqv2bAz4ev2QvuI29oIgMKVtCdph3ZzOiuCiSX2dADCXdBOGl3+MqlMeiyVVgTJg+4mcVbp6LYHWikZBpr86xSfUfADqPLYoa7Q/57zEHpu5PJcsAd/kYnleSty6c/QRngMoWv88ySOcWn+rmdcHgVqVHM2MA4iDNOfakWs/i9DbaW9LzS1DErj4sD1X0+AUw4PuICrZjDwDUlIpz+/Utd5lay8QOwjQQmkh6b1XYEYbNuw/sk+ACtkuvxBtykRM7Qy2u2fJUUOQj5QA77h8ju8kWllxO0OIcPVqFYwabVPWU91gq3C/w==
Received: from LV2PR04MB9812.namprd04.prod.outlook.com (2603:10b6:408:34e::22)
 by IA3PR04MB9474.namprd04.prod.outlook.com (2603:10b6:208:514::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 21:56:40 +0000
Received: from LV2PR04MB9812.namprd04.prod.outlook.com
 ([fe80::fa03:4e35:cc4f:3813]) by LV2PR04MB9812.namprd04.prod.outlook.com
 ([fe80::fa03:4e35:cc4f:3813%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 21:56:40 +0000
From: Clodagh Aisling <aisclodagh90@hotmail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: A Thought About That Grand Piano? 
Thread-Topic: A Thought About That Grand Piano? 
Thread-Index: Adyis8p9eAcQwnbtQGmFw+yZk5yL2A==
Date: Fri, 20 Feb 2026 21:56:40 +0000
Message-ID:
 <LV2PR04MB98127528FD4084BC80D2AFFAD768A@LV2PR04MB9812.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR04MB9812:EE_|IA3PR04MB9474:EE_
x-ms-office365-filtering-correlation-id: 1f64643b-2244-49c8-b83a-08de70caed92
x-ms-exchange-slblob-mailprops:
 bHQ38DpbEWAayy1Fxvh9DGGZQkLoCo9lkiucvy2FDSFRo10ZnsD+4XglYFleH5rGAYvmQXCdyl3gBRDEr2GMtl8/4fCieyVLzBflvcKVQBF5Cd/LMB3BQ9N+xtHl5CunTPxjRc/kMX5acgj4oKd7wFOKzNH2/wNTv1Vusg6z6tlvCEn9VM+vVzdY0PrLRXOd+XdK9Ak7VdyuBKu1kD9w2hGKp9+AxNRLWGScYwTIBEjKrA4M0WwDGlA4C3mbLJ0apceay40SPGFyFQUzbD5OCOiBkYqjxSKylm9nQqz0LI5N+1CYgFqxYEwhP4V0HpH56upZiibvJG0dnYXt/ypTolVig4vTF9l0tJooKErd4fB8yFL2RTzll0K8n1U7BX4g3tq5/oWwv0O60XrAu+LPxBe0E5hV//8Rl5P1lxS+EqzFaY/Yrb9f9APzuecgsN6ypVxDQdxXDN9Gi3dGAa/ZFt5J2QirPnCtAJReoRMJJKgRbvE9g6YB3toPfZVrlQY+zMiDiFXdcPCx2mZIyMMwwlglRh7RnF27IJhgqWjWwNMJSS+amiyyBfCh8KQjeAYviTmtO3n676iemuV6HQliOFUYjKpmpjoCGZghqgUMIzVr47U7z1VfiFmjvutncmsNUe78Mgzr0Rx+873v3WVCyuSXafueMD4ZHuOPA1Kc7cGjJ+UqDvlUtw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|37102599003|13091999003|20031999003|39105399006|10092599007|31061999003|461199028|19110799012|8062599012|8060799015|15080799012|40105399003|440099028|3412199025|102099032|19111999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GsfRNyo9CmEgLzuPTgSMLiqq/yyJdqVgtlfOjzVMvPpP5M/3y2AlurL8urij?=
 =?us-ascii?Q?FboTsqS2DW6jcxuzMjdfXUoKokaF56Ye7nUuUuAubNObzv7+s4j0AItTmYSB?=
 =?us-ascii?Q?jidmKtrWC/yUx9whfLfP7UJQnDgf9luU27Aod6KVpTZojtxO3JFWBG03eE8q?=
 =?us-ascii?Q?M1T0Z+2DCZotd5C/Kpsk9hHEoVyD3OzzX/pPu13nzin/UUTEPunSB6PlNXVc?=
 =?us-ascii?Q?yD8Hl8RTkWHm6yFfNbyxAYEEG6qQSHGsAjIJe/reO59O0taZVcrxTAOcCqy6?=
 =?us-ascii?Q?5B8EGDcQqLm0UCCuihXs5wRNcuNVNWQ8NPvCKzVg+iPidqg08k16KWjJ5N2w?=
 =?us-ascii?Q?MFjnDSsdj28UHYhtdEhCF0ZJFWV9mbAZ7dBnoT8dagn7LivvOSuyXd3mx8PE?=
 =?us-ascii?Q?LbmruBZPga4N/y/rDzWp8hRCu8aUhm/qmo/phW16je/7+mtQfUftvAvO4UMK?=
 =?us-ascii?Q?ThyHc0teCU6cSaWHQn1/Tu9Uxj9yx4y1LIy5Yy+J9YUykgC6/Pc0yP4HV6ot?=
 =?us-ascii?Q?jomIPd23i5wg6KDDi8qcby14NS4Tr0Pn3Ct/UK+PO10VcJe3Fy7ognKWa8Gk?=
 =?us-ascii?Q?ZN46DWgDYbk795yd8KC0lFWZtKKAotw3PYcnjbKwZQfBBP4QyPoMBvKDZwji?=
 =?us-ascii?Q?RFPk4i0lSKNL8D2owHJYCLh0Tp8WrIHeB1MqgHIKup5pUoQ2KryXj4AXRKEw?=
 =?us-ascii?Q?JrLWqRZo137urIWJm1FhmXv+b9KzgMwSx8DLUSy1w9ueYJ6UAVPiH06rztUk?=
 =?us-ascii?Q?B6DcusWOtJXW05gW0b4QE+MTZiCYxUf4DtNfoYHutXLIPm1EDG27bsjJvjrY?=
 =?us-ascii?Q?PZMDBQavDwOuQN9gwMJhUUjr8JhYGeBYyIokmdtmsZujyz5L9rR3w72T7t+R?=
 =?us-ascii?Q?VPN4jW4tZUrfgXHKP2tqUoqmqb7UHd4zCUMTgTa89w13nr6WhGLhL3BpReeR?=
 =?us-ascii?Q?5KnHlAnT3/Lm1wbJOSqgUf9kpkQohNich4ceC7v17rPlQnc5oGYwRjZiLg/A?=
 =?us-ascii?Q?rYrXmL+cycGcIqU97a7R4AzfZBB7vftZZDiXQQC5pOjvtjphNUmyOFRSihYC?=
 =?us-ascii?Q?W85lj+65NToOcBFzQ6r0eaBSBAPJX8OFtf/42WifbpCY/Yu5S6ct3lpYZ3AJ?=
 =?us-ascii?Q?RgTfgzE8fl2FC3pBs6zRbyJsxLji/uEEJDD0hqMVXcppLLoRoc2sUQOAC2Nb?=
 =?us-ascii?Q?mW3w9C+cMq6XhN+R7HlCUvOzAWi3QBWIDQOPkl7suH2Ooka+/BuZQTrhbxjl?=
 =?us-ascii?Q?nYDsm3X9IirPi1HJfWm4xxz8dzXJ8weTDqLnOldn1fUYf/NyZce0caLyKX2A?=
 =?us-ascii?Q?V5xifwnx7yVgrQ6PUasxWfQceSiGD8HUR6BTEQ+J8VgkXA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UA3fWenEMqroC85OZ3nxvsgTWvXWbt56MbMBB3ktdu+om7Isww9w5T6zeopq?=
 =?us-ascii?Q?JlhOHprNsHLT1kbKFNspV8BZcwYxGlsl4/Jh7gGjwoZAN0wNxwnpw1JriXmh?=
 =?us-ascii?Q?LmwIzi2JBEz3v5CLRlVHC3wiu9BLqhEFD0TeY9xB3P4F46sKiHslNxGV58bu?=
 =?us-ascii?Q?DNJQA6tYrNe9sPBXZGUNjw4vOx9IXSQ8jveFwUHU1BtAWKidHmlvTLBBAt71?=
 =?us-ascii?Q?BcDYcjovhgW1ssUs7Re5DiMiDJzPJiajnsS0LjozWEnSEGDjrJAfq+PvtUGT?=
 =?us-ascii?Q?A3/FNVJe6GxeGh71ei2p3nPndg691rnNzj0fImHrjdrYyZlw3hUg3bxq6N6e?=
 =?us-ascii?Q?dxoPrOJ9nQ9UHYJLb+EhQ2bIL4BVPQ8c0+iFycBUW/adEK9n1xxyHHcZkdNq?=
 =?us-ascii?Q?sm8yE7Wr8JxMoBvJuFySNwQujzRDpM2lHGuBeoeUOvqB45ntL3PG8OwrSUxw?=
 =?us-ascii?Q?lABlAzobkXtHx6iYCDpKi8V0PdH1vuknNqMFA4Z0CKCky1UNQEf6SHOQcj0r?=
 =?us-ascii?Q?M00uXm7e23iHYv+ZusW2DIjsHKI3cr3PghW3RbLNc3kPLMTrihIICzGNBehy?=
 =?us-ascii?Q?zRmPR6ZDRFA1EJdArV+xzbCRSfU63IKwmXphmFZp/kpaRRYgBOUr7fOrXQib?=
 =?us-ascii?Q?ESgmb/2CYlyMLRvqub9YqJ1njdDTYVcILMo3mFH0phSvvsWDy4SW/wjSMMZD?=
 =?us-ascii?Q?DAfbH0O2hLU8aYtV7v6OF2v+FpSq/CrER+NeQQlIy1rOJ4VvlQaBdsJ3g2wn?=
 =?us-ascii?Q?C3zQe08e2yVujHPBELWRI5KOQqBhGoOc4sJAcQ0eLeWJYrDJ4ENOl9O58lz6?=
 =?us-ascii?Q?LVsZlbNjKs0CE5NIqrW6uYLOrSBTlMkXcsr6kmjEg1vNlehKakAHJE05+3lX?=
 =?us-ascii?Q?lrn/ImoTiXaLS4z1xYqbn4t2b0gp1EaUCW6Re5troI58qog8P+gIxb9LlSyt?=
 =?us-ascii?Q?KlBE8vTro3dwlHeTVMnj+ryh/swCiuv4U1X291nqOjIC3ZkZm9gvvmNihYGI?=
 =?us-ascii?Q?JkqAZfyQD4Oj0ADlhSTCnWjOSNJftwrDPcrC6SfxzD6sccx6ehWlCeo1zkLk?=
 =?us-ascii?Q?r6P3K/9bddBLIqWz1jCmciKgo3Hb++JI8VULIcuURgmPS6uNSMX3T/g0ZDf9?=
 =?us-ascii?Q?WX0fpn3fpoBmt6ClILXZuIbGbzVydrpaG+bU8g03kidZvV0fXU3LnU/NZP49?=
 =?us-ascii?Q?hg1WAUiPe8OdkraW8/EiJX3/SCjJfgiLoQO9e9I0ZkFTNLwFebd8yTa/KQ9h?=
 =?us-ascii?Q?99HFf95LlyVgtMO7ZpoiBVifvDUy8Y/pI0QEQD5IapFoMLD4cqZQlcDxZ85z?=
 =?us-ascii?Q?DgNr4ApPIEKUwgD7d9U6PjqdsaKBjICHpTx4EmclyBakgatIh5aRBW2S4IF0?=
 =?us-ascii?Q?qmZ4d7aV7NNjCYsgPMu6G0nQQE+v?=
Content-Type: multipart/alternative;
	boundary="_000_LV2PR04MB98127528FD4084BC80D2AFFAD768ALV2PR04MB9812namp_"
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-33ac7.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR04MB9812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f64643b-2244-49c8-b83a-08de70caed92
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 21:56:40.4283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9474
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[hotmail.com:s=selector1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2340-lists,linux-erofs=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[hotmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[aisclodagh90@hotmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[hotmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV2PR04MB9812.namprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 7726416B148
X-Rspamd-Action: no action

--_000_LV2PR04MB98127528FD4084BC80D2AFFAD768ALV2PR04MB9812namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greetings Linuxerofs,

I hope you're doing well. A friend of mine is giving away her late husband'=
s Yamaha piano to an instrument lover. This instrument holds profound senti=
mental value for her, and she'd love for it to find a new home with someone=
 who will cherish it as much as her late husband did.

If you or anyone you know might be interested, she'd be happy to share more=
 details.

Thank you for considering this, any help or advice is appreciated.

All the best,
Clodagh

--_000_LV2PR04MB98127528FD4084BC80D2AFFAD768ALV2PR04MB9812namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"MS Exchange Server version 16.0.19628.2=
0204">
<title></title>
</head>
<body>
<!-- Converted from text/rtf format -->
<p><font face=3D"Aptos">Greetings Linuxerofs,</font> </p>
<p><font face=3D"Aptos">I hope you're doing well. A friend of mine is givin=
g away her late husband&#8217;s Yamaha piano to an instrument lover. This i=
nstrument holds profound sentimental value for her, and she&#8217;d love fo=
r it to find a new home with someone who will
 cherish it as much as her late husband did.</font></p>
<p><font face=3D"Aptos">If you or anyone you know might be interested, she&=
#8217;d be happy to share more details.</font>
</p>
<p><font face=3D"Aptos">Thank you for considering this, any help or advice =
is appreciated.</font>
</p>
<p><font face=3D"Aptos">All the best,</font> <br>
<font face=3D"Aptos">Clodagh</font> </p>
</body>
</html>

--_000_LV2PR04MB98127528FD4084BC80D2AFFAD768ALV2PR04MB9812namp_--

