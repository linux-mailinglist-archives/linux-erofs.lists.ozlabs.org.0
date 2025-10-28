Return-Path: <linux-erofs+bounces-1297-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A39C12C55
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Oct 2025 04:37:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwbfX4vJzz3fpL;
	Tue, 28 Oct 2025 14:37:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.183.30.70 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761622644;
	cv=pass; b=aNgtA9KWz2Wid3g7nC3WErVXeypvG2YzZfvVP/pD1XWiXNB0GRZLDynfVwNDnCVZ3/Wka9czS2TGcpPRAwIIXsQGlRtOb5eZveJ3qY4f2O1qAverNSLGbwULSrQysqh86ZdzfEFlN2f3TkurDpaOHvLwHptgnD2lsNqqIWMWalr176cNHMeQOKNDgP6ysAJ7QSg48Z0dtqsPepGRBdhdGu8Yop6VQGL0uZ35ggY+vbVs2/pDgHfLIfvENZGUrR/iY6TT8D9N1ijN43LzPRyNEZZWUzZKh8vji2gfWsJNSbf+eYxTMpOmLZQT6mKGkpsgncibZ+EJv/k/qK8ONT9qfA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761622644; c=relaxed/relaxed;
	bh=DpUeBhnmuxZbxT1vnNIx4B6WuHTd1yJKOYRE0SF4/nc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bjNE0YOgfNpG0GSGcUVgsWtrirTOk0tKsyr+c8iR4YV9ghOvbcw+otu+SoVUNtVnyn7d09tZKf38mTqN/EhGZKBNK/uAasCpiqfxPwGMSxevnoKbdJ1/x+cGuxdi7sCQkcCL+hG7Q6YwlZVci650e78M/lKAmWVO8tij39C4Gu2YEI/dIVj9zWBJxOpAmiSYkyi3bbHpzLmDyzz6/z1kFpGK6zLEMNP9Dz6anagN30E2TVESCC0TFx/FLpcFT8gIAmyO1lyG1eAWbwQwOx8/vDiG244gAWAjLpqds909oR4aRilvv3hev7ZMAUXzfL6SaJTc8REPjedtmoEyzL7Wzw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=YDi80YYN; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=YDi80YYN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwbfW4Lgjz3fpK
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Oct 2025 14:37:22 +1100 (AEDT)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RMe4dU024803
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Oct 2025 03:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=DpUeBhn
	muxZbxT1vnNIx4B6WuHTd1yJKOYRE0SF4/nc=; b=YDi80YYNOpvbRuxUABvttOW
	gHXvo26mZ7XFNuORibtfB8STV8X3v4xShq/xQBswAxxwWAqdFVrZXb73Qm8b3lWk
	WIBeMor82a61LJvTOfwMBwhY9QWs9K6SUhabcDhH3w+gTe+03uLDzhEt0P8hPw1K
	jPdWdogDUBmpOVyKssCwgj/Xg3s8Su52F8IUix/3FpORIRsKCuL4YcKd23DBsxva
	KY0SWr2XsTpqd/yT+I3I/7q+YWGEu/FbBorpCF8Lv/Kt4X5s4EpH6QQgE5FOZy7B
	29L2Kg0NtbWVPfwoaBupcJHKO2VlIhjeaaRUid6FY0K55uWygYMysys1SzNAoxQ=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012031.outbound.protection.outlook.com [40.107.75.31])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4a0n43kcms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Oct 2025 03:37:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdBJltTYPziqJYXCV3d1BkfwPuZ7SX9b40W+Ui11IKIylWevyoziVoPGtGq/Mm8Gbe7NCyUlY7mlTIk8Eqe/VZg8IV11EgEHiYplsriNmAf/wGinGYNBRVixei2+tzJSRyp6+mcDrYLcL8c/xfKMOlkf0hC0RxU0sDrefHS9s6crAhzb8wzL3ZYVA5zbXQ/QNRqD04ZVPXLJbcXE5G2Nbr3wCI6E1zzOo1FS0Oj7wmh016JtvOzH1FV5yE3kCQ6pN3j01pxpsXbx7WIz6KREMEnYyqK8dSHyLDyhlG3PW77JnlRmNLmaXUJ7ddfbQbP3da0Y8EIhuBNCgHdAse2+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpUeBhnmuxZbxT1vnNIx4B6WuHTd1yJKOYRE0SF4/nc=;
 b=l+LvJBkokAOofyl3APLI0l0gLNwgGx9AoYcSkqj6fnZMIGydaIQhOFXlfkE15wML5hL9uQT8zfoqX7u+vhvWkQV/UnLSmIR5FxQzh2carJ/+kP/CuvpkvQSvIcqytYlDRdBRjdnqmiN3MKoL3QA8mGM6wJfDp3xfz+UoAWug+D7eOTg6JcYeG+hqMbDH7mdOODh2kN5aJcZV5muJwXypXEeuwY5WlfkRSI2Jd4oxqj0ZqdXotNenu93gLEBr4gSmos95qtYFCEw/tMBux0RLbMxzhA9JuctWrsZqiGEJMolj6y2sRmWoYqAJQzY+OD7/ATQoC+/LzgIryYKfU76cZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by SEZPR04MB7795.apcprd04.prod.outlook.com (2603:1096:101:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Tue, 28 Oct
 2025 03:37:06 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 03:37:06 +0000
From: "Friendy.Su@sony.com" <Friendy.Su@sony.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
CC: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v2] erofs-utils: mkfs: Turn off deduplication under chunk
 mode with '-E^dedupe'
Thread-Topic: [PATCH v2] erofs-utils: mkfs: Turn off deduplication under chunk
 mode with '-E^dedupe'
Thread-Index: AQHcR7tC/0I4KSmrv0OW1qgQPcSUkrTW5yYp
Date: Tue, 28 Oct 2025 03:37:06 +0000
Message-ID:
 <TY0PR04MB6191E497F3885D0CBF8F593FFDFDA@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20251028032809.1371395-1-friendy.su@sony.com>
In-Reply-To: <20251028032809.1371395-1-friendy.su@sony.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|SEZPR04MB7795:EE_
x-ms-office365-filtering-correlation-id: 2194f836-d273-42db-874b-08de15d3447a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7CfFCyXHt6Gtbs2vLCzZSVSyDolskA9NTFAwePo1w1XSPvMEKUFDSK/T8u?=
 =?iso-8859-1?Q?tHpnXzTiKyRn5x+oD+xETtB2J33wv1isabGcFUhDhhSZbKc57TcCs+1JrJ?=
 =?iso-8859-1?Q?j3LSESWLn7OsOnCh1XhBJNqTz/4emWAoTPX/WTGaxxl9kxbF1kl2t/0tpO?=
 =?iso-8859-1?Q?tA+EYINnVxMWxW7RQ0LiYdYHaUUXgO7Ji9zkjozQ1iWAaF87OgAgUJmmgA?=
 =?iso-8859-1?Q?dI6Dj2pWhF/I5VVyRzpLqi7QVWAGWzCxYxmtd6uCDdQSopZyDH7/kgZ1vU?=
 =?iso-8859-1?Q?3LU5IOmkWRucijGH5+pv6YuKcmyQGAbiRNX9z50HeHto5YR5+iB+6/q816?=
 =?iso-8859-1?Q?KuREPGmKEjYZMNYmZwd/kmvm1Sq4ZhSRjIRWZAEAxqNchquEA2h2MqaLMf?=
 =?iso-8859-1?Q?nrZGKJQloqjxOSm6CIewBGRF7GIKZKG84HYuSLz8g8PUP6mKJ3hni9xsvp?=
 =?iso-8859-1?Q?1PWNJg1nvAJRiAdiyVFo5SgElrdXZ0VWT7AqHb1cgun3xb1ZI39d2Rj/7F?=
 =?iso-8859-1?Q?dwwLJ7GzRXIdmQDy8eBECMZ+gHygjaEIY/HsEfjolBZOV7eAOMYICwL7uj?=
 =?iso-8859-1?Q?bk2kZ0iOG2PFba2HXIht5DSeq0DuBZGdA8OypT5ffwwoPUm6bPic09GWeA?=
 =?iso-8859-1?Q?huCYaDgDvtjceAv0kp6W2EPOJbPlym+y3ihgYk0z5U5a7BcK4nDFsGguED?=
 =?iso-8859-1?Q?roKbrqZPIToUwMSIK+BjNz+/IKRuyMkkrPYux92YZDzcTkz91sCz0+fnwX?=
 =?iso-8859-1?Q?Euvz+9zCIpVgWelRrA74qMOZnX3bz+tQanKGLTZFq2RhfzuR5NMzS1tHOp?=
 =?iso-8859-1?Q?2AMGDxyulAhPL3iVGenVFwLzHFPtvOMEm30k+5yw4z1eIu3hYG6ThoA5Lq?=
 =?iso-8859-1?Q?DvK4Pmm9VV/fKNqxnkIGYfShmnQSRo68XBPKxJo6lx1BqIHP0p7KaYMy9x?=
 =?iso-8859-1?Q?+VRMHqVR5EOOCgOU+NcoBQ/xot04vFLA31TfFBNDpnMSxxR4r3A8ArLVYm?=
 =?iso-8859-1?Q?o+s2+am+rT6b12H1rK/ImMR6NepQdNxXvCvEXluZtAwuCU3zTroMdjEihw?=
 =?iso-8859-1?Q?6gvxgEG9/eBmo5yGT6kKXdzMEsTdUIoCS8fAG/94jZRH5UOwhAULbztOoX?=
 =?iso-8859-1?Q?gNRb5pZivo0OTnlgX2XmlJg6ubez5OcBl9id1kJwGmxmv+uGHzKz64pUZi?=
 =?iso-8859-1?Q?HDT6oorDp7ZKeF45Pvol+UAHgIJSn1evNf1lJ83EaggOPS6iJK/SDq/ky4?=
 =?iso-8859-1?Q?Spb7Ly3+qJ859D4jCNqfMaWEjoAa1kw6uw7o83n6VGqxVs7nzq7fCGiY5g?=
 =?iso-8859-1?Q?6WcrqmhtQvdNKI7iW8uGqgSJBDNXOg+BJKSggIy/ukAz3U7uxxKy4m8qCC?=
 =?iso-8859-1?Q?Qo+zAH4P6toO8OOkr3Ukj/I2n5ZUjCasGMhDxTpl8l9XStk0SnpqSKpBkj?=
 =?iso-8859-1?Q?c0GTzMyjJDbygYCRPetmEX6Domk8OnbnpY6wBzdiuMIW/A2xMhmynsqJ33?=
 =?iso-8859-1?Q?iaMaH8hQQjI67KkYkAjNjRlx6Y31EupuBrK/6bFuMBG8aKAxuAcDW29aMw?=
 =?iso-8859-1?Q?726O7vQm4nTwrXRQy4FSeB310mSp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LRflwVB8ErOxAfYW8kDoAEAhiHT6UGhMCSJWPzZkyZedy582SR0je/Ekp0?=
 =?iso-8859-1?Q?4wtEdMyG1U2gC/1To41cs1FVrAru/4lyVAAbiv8zmUfyAj+PYJvDwFcoeR?=
 =?iso-8859-1?Q?1P1SL7yW7w/4Ltgsf1TX2lYSt7n3B+ON0dhhqPtSNpRGrvcQOCh9ocSmJm?=
 =?iso-8859-1?Q?Kujr5HhPL65Wfd1q8ULZNFalF1VRjkM8i276oV7vTNUWMLMQ+bMhRN38ci?=
 =?iso-8859-1?Q?4zxLeOtkHFuS4x4HoRxeSSPXoDKZMxvDL1Wj4YtlYcApLfuQZ54PB7br3r?=
 =?iso-8859-1?Q?h8CtgUbw0g20KQo0WyFyGb1LPolg1kPCPTFv2ViRTOgtnU8UsBV/KimIFW?=
 =?iso-8859-1?Q?qR8lLeFKUpMjMPlGdXV1ax2oXC2x/ISYxpQ9q7v7vL4GMGNWQDSKOvIC0B?=
 =?iso-8859-1?Q?+JUS2n8wtwVbPs50amPVrQE9p34pbpP0ZB9gGnTmEohjf047Yyh24nhTbb?=
 =?iso-8859-1?Q?o39AjedGJdGoWadZrPn2dPmFjzrUqJo2XzeNmyqCpusrMPg4qVV6UB6XXr?=
 =?iso-8859-1?Q?bJBXoArmdZqWFOxUXm+vxr3wZyrMmkojtwS2rAbz9aS3UjUsiGvspBF8y2?=
 =?iso-8859-1?Q?rtEZ0ABGQKvp8weU5cfA9DzoTyEwTkMlIEY/lc1yeDisdIzOmcy5NdrsmP?=
 =?iso-8859-1?Q?LFKN6BYUElO+mwlUk6FBMmcPcI9/j7BuhwEdrX6eEzp2zoFnUKlApQHYd9?=
 =?iso-8859-1?Q?rNj3pWDcl8SAsRdFBqVpZYz7MIzEZYThIR2HaRJ0qmEs9ilpsGXgr21EYq?=
 =?iso-8859-1?Q?jb2cszOt+m/t1WJcaIr7gNuiaNY3FpGGGuht6ZV3YrA8U29Jlmt/M/2mvE?=
 =?iso-8859-1?Q?9272GMdWgfd1o+OU3eFt31XFyWV2qcsqC8R5FT5hLEiElTYtT5bas3oBNW?=
 =?iso-8859-1?Q?reNBHrnIWsdt+aj6rMRc/QpR5apK5ZQ4sLmMUVDRjGrG3oDdjLTkCZyT7E?=
 =?iso-8859-1?Q?nRE20zGxwuSplv2wb+v/lQliIQw/xNp+rvTYvguUmCyblaWltKT7ArVBR9?=
 =?iso-8859-1?Q?pOWNU+xuIK9xb5AlSayJHVAOF+pLTcjwK+3Ifz3gO9n6wVZI9TlKfy8l6b?=
 =?iso-8859-1?Q?2QCY+zEZPssTMFyr6R7kLw+Qj629qv3PSy5KLuXZ+tBG+HKBjeY+2+rOig?=
 =?iso-8859-1?Q?mes0GUNFBhbPNE4HGXPQDUODGarx98H5W3LLoRkX0jsUlyzJ+E7HQVnKxH?=
 =?iso-8859-1?Q?wuTQ/f4nBmilmYWgKFx+xpcbWSLxJCV2z8/A3jJ7CJD3OPcLmFSSFwEtjQ?=
 =?iso-8859-1?Q?qDmb1dDDuK5nNq5Dn8xV3+qJqcQ04WBMizGdgfxlkoJ4HEySGJgjIst0eL?=
 =?iso-8859-1?Q?X7uBvyS5eG3RCMVtUpQxfI7Gkz7yOT4r6HeGpETQmpWqfkqX3Bx+XkN7/4?=
 =?iso-8859-1?Q?6QWyNoswzGUuVw8sjbddmFC0b5c08KIoxOp3TkXQn58V6ZmnzF8q72g24h?=
 =?iso-8859-1?Q?f5Yrc5xGUZd5xB6JO49sSq0Rl9MbUnJ7563Ej+rM9tD02vYGyiEbWqdtia?=
 =?iso-8859-1?Q?t+nuUoMkfBGIDD9vjWFukRisqaHcj8z29b/xmxijHugeXHzIQkatUQsXov?=
 =?iso-8859-1?Q?HF3IFSq+RYzRo9jcgoM4DdMp00a5GZqPFu4A5S4PO5YZ+Xujwx9P8NL3Yy?=
 =?iso-8859-1?Q?ARTA2+Hy5XZyDq2U12ypAxPGVUbfFQpQN/H2oEHBYNxJV+nCkDwER2Lw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q67s3hB37wtTaCHtw9IfzPVw7LmmgV+5BgM15+VjBHayNZLe+EgORnKyNjBE9FNaMvKjmwZ3lCJqSdYhcZOUl24hz/yv7OD/FpDQjAKv9mDkJ2Zb+qI1YQiAKrPn1BXqB764nF6enxHMSbCBCgrG4gwycv9nP6MW74ArZzmvThs7Yf6E5xZ5klx7Tg6AMaUoqeWHFx4ufPqM3oXCpTbZRcCy7bcxqsrZdJs90KGnUCU7XJW56ezszOwn3rAazw7BALdVJHE4A3+1VBq163OQ+GI4m6aU9MXrQW/Jgumui/A41wUiBohkkj2a54T2AU7jI+G6LHFFXtOYFnwDTsIaBtUHQpXaQFTb0emVWf0qpaCgeWJqJTa/GBB8HPCupmKurzo/W3Qujvc0Z2X8ieyClheu1pRshnek9+Ves8/bEYffKl29QKS/W3wngiiUzhVgTiHobCXwVdQvRjCNEhOnQmogPLLAdwOzhJ0HjM1paxZ0UVlcb7Wei44W+UD+w03U6IoXQLyiqjbKsEroEvm01wkEFmHHidGKTqonvfSHUi5j80vraA7VY29SybEqKHMOWHFZnIL7uiBACrdY5il2VxF//4nLCkXda+57CrIIG4PQDCVIAhrRbuRorTi/TNsL
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2194f836-d273-42db-874b-08de15d3447a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 03:37:06.4192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CutrOOFX+5/tETz1rbpOglXCu7jGp0WSmx+yS87Q7pYvbbjHDT9qYQnqScQtEv55rzVf9OrwOhYZKhXFhNnzEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7795
X-Authority-Analysis: v=2.4 cv=fPU0HJae c=1 sm=1 tr=0 ts=69003a6e cx=c_pps a=wqg/xdzaCh6LQOKqGP1W/g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=z6gsHLkEAAAA:8 a=voM4FWlXAAAA:8 a=4IZ_uXwMtjJjk55MrZEA:9 a=wPNLvfGTeEIA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: HfJ0X4LN1gLNTOt0_jwlTq1cslhLK0bY
X-Proofpoint-ORIG-GUID: HfJ0X4LN1gLNTOt0_jwlTq1cslhLK0bY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfXw6b1r6LIxNfp D+ozX6uiBEBjLMqfjButjv38HMaQPGhEMsjkajfnayJjrqOQnOP/1K3mLFEtPKwHvk7uS4L/neG Xk8NQUSLa3gPVXfrR6GEKTwn1eSZpzTzerdK8en9Sj4TqJf8C3d9AwMyrolE/MJHL1sIFOwcwpn
 CbrpKRVUNhjK3iZiZhs4IUoCDNevoSa/3ER4CIgcG2yYo5KaRgdhjn6iCw4qmiieVKGwbOs2yhn /fr9yWg/wUftSBWtxhxhDF2cJ5L3gccgb2p5gagtj0XB/6r2eJ09C1FWeJKxNiAOBQS78do24st wvA3zFEoLUEzKx0F2wdXqtoij9MJPMhkuxi7kkZK29fns8pBnlRLSm8yHD7wOCDC3cb+Tp2zh6f
 rTHbCUihZGd2O07jAG/oXl6ZTaa+1A==
X-Sony-Outbound-GUID: HfJ0X4LN1gLNTOt0_jwlTq1cslhLK0bY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Gao=0A=
=0A=
This patch  changed "-E^dedupe" behavior under chunk mode. Make it turn off=
 deduplication.=0A=
=0A=
not chunk mode: =0A=
=0A=
-Ededupe -> deduplicate=0A=
-E^dedupe -> no deduplicate=0A=
not specified -> no deduplicate=0A=
=0A=
chunk mode:=0A=
=0A=
-Ededupe -> deduplicate=0A=
-E^dedupe -> no deduplicate (implemented in this patch, original is dedupli=
cation)=0A=
no specified -> deduplicate=0A=
=0A=
This patch does not affect compress.=0A=
=0A=
=0A=
________________________________________=0A=
From: Su, Friendy <Friendy.Su@sony.com>=0A=
Sent: Tuesday, October 28, 2025 11:28=0A=
To: linux-erofs@lists.ozlabs.org=0A=
Cc: Su, Friendy; Mo, Yuezhang; Palmer, Daniel (SGC)=0A=
Subject: [PATCH v2] erofs-utils: mkfs: Turn off deduplication under chunk m=
ode with '-E^dedupe'=0A=
=0A=
With '-E^dedupe', even under chunk mode, deduplication will be disabled.=0A=
This is mandatory if mount erofs with DAX.=0A=
=0A=
Deduplicated chunks are shared among multiple files or different parts of o=
ne file.=0A=
Kernel DAX map got wrong when map them.=0A=
=0A=
[    2.031496] WARNING: CPU: 0 PID: 1 at fs/dax.c:460 dax_insert_entry+0x36=
e/0x380=0A=
[    2.031978] Modules linked in:=0A=
[    2.032173] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc2+ #111=
 PREEMPT(voluntary)=0A=
[    2.032688] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), B=
IOS 1.16.3-debian-1.16.3-2 04/01/2014=0A=
[    2.033291] RIP: 0010:dax_insert_entry+0x36e/0x380=0A=
[    2.033591] Code: 59 fe ff ff 48 8b 30 b9 09 00 00 00 83 e6 40 0f 85 70 =
ff ff ff e9 77 ff ff ff 31 f6 90 0f 0b 90 85 f6 75 ae e9 34 fe ff=0A=
ff 90 <0f> 0b 90 e9 02 fe ff ff be 09 00 00 00 eb e3 0f 1f 00 90 90 90 90=
=0A=
[    2.034654] RSP: 0000:ffffb93fc0013b88 EFLAGS: 00010086=0A=
[    2.034948] RAX: ffffe124441dc140 RBX: ffffb93fc0013c78 RCX: 00000000000=
00000=0A=
[    2.035339] RDX: 00007f310337c000 RSI: 0000000000000000 RDI: ffffe124441=
dc140=0A=
[    2.035730] RBP: 00000000020ee0a1 R08: 0000000001077050 R09: 00000000000=
00000=0A=
[    2.036120] R10: ffffb93fc0013cd8 R11: 0000000000001000 R12: 00000000000=
00011=0A=
[    2.036513] R13: 0000000000000000 R14: fffffffffffff000 R15: 00000000020=
ee0a1=0A=
[    2.036912] FS:  00007f31026ad940(0000) GS:ffff90436812c000(0000) knlGS:=
0000000000000000=0A=
[    2.037352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[    2.037669] CR2: 00007f31033c2216 CR3: 0000000001d17006 CR4: 00000000007=
70ef0=0A=
[    2.038062] PKRU: 55555554=0A=
[    2.038216] Call Trace:=0A=
[    2.038363]  <TASK>=0A=
[    2.038486]  dax_fault_iter+0x286/0x6a0=0A=
[    2.038704]  dax_iomap_pte_fault+0x17f/0x370=0A=
[    2.038950]  __do_fault+0x30/0xc0=0A=
[    2.039153]  __handle_mm_fault+0x90a/0x15a0=0A=
[    2.039391]  handle_mm_fault+0xde/0x240=0A=
[    2.039607]  do_user_addr_fault+0x166/0x640=0A=
[    2.039853]  exc_page_fault+0x74/0x170=0A=
[    2.040087]  asm_exc_page_fault+0x26/0x30=0A=
[    2.040319] RIP: 0033:0x7f31039389bd=0A=
[    2.040519] Code: 08 48 8b 85 68 ff ff ff 48 8b bd 60 ff ff ff 48 8b b5 =
58 ff ff ff 4c 89 f2 48 03 33 45 89 f7 48 c1 ea 20 48 89 b5 70 ff=0A=
ff ff <0f> b7 04 50 48 8d 14 52 4c 8d 24 d7 25 ff 7f 00 00 4c 89 65 80 48=
=0A=
=0A=
Signed-off-by: Friendy Su <friendy.su@sony.com>=0A=
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>=0A=
---=0A=
 include/erofs/config.h |  7 +++++++=0A=
 lib/blobchunk.c        | 26 ++++++++++++++------------=0A=
 mkfs/main.c            | 19 ++++++++++++++++++-=0A=
 3 files changed, 39 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/include/erofs/config.h b/include/erofs/config.h=0A=
index 1685adf..92f040d 100644=0A=
--- a/include/erofs/config.h=0A=
+++ b/include/erofs/config.h=0A=
@@ -27,6 +27,12 @@ enum {=0A=
        TIMESTAMP_CLAMPING,=0A=
 };=0A=
=0A=
+enum {=0A=
+       DEDUPE_UNSPECIFIED,     /* no -Ededupe or -E^dedupe */=0A=
+       DEDUPE_ON,              /* -Ededupe */=0A=
+       DEDUPE_OFF,             /* -E^dedupe */=0A=
+};=0A=
+=0A=
 #define EROFS_MAX_COMPR_CFGS           64=0A=
=0A=
 struct erofs_compr_opts {=0A=
@@ -41,6 +47,7 @@ struct erofs_configure {=0A=
        bool c_dry_run;=0A=
        char c_timeinherit;=0A=
        char c_chunkbits;=0A=
+       char c_dedupe;=0A=
        bool c_showprogress;=0A=
        bool c_extra_ea_name_prefixes;=0A=
        bool c_xattr_name_filter;=0A=
diff --git a/lib/blobchunk.c b/lib/blobchunk.c=0A=
index a5945f8..7d5d606 100644=0A=
--- a/lib/blobchunk.c=0A=
+++ b/lib/blobchunk.c=0A=
@@ -64,19 +64,21 @@ static struct erofs_blobchunk *erofs_blob_getchunk(stru=
ct erofs_sb_info *sbi,=0A=
=0A=
        erofs_sha256(buf, chunksize, sha256);=0A=
        hash =3D memhash(sha256, sizeof(sha256));=0A=
-       chunk =3D hashmap_get_from_hash(&blob_hashmap, hash, sha256);=0A=
-       if (chunk) {=0A=
-               DBG_BUGON(chunksize !=3D chunk->chunksize);=0A=
-=0A=
-               sbi->saved_by_deduplication +=3D chunksize;=0A=
-               if (chunk->blkaddr =3D=3D erofs_holechunk.blkaddr) {=0A=
-                       chunk =3D &erofs_holechunk;=0A=
-                       erofs_dbg("Found duplicated hole chunk");=0A=
-               } else {=0A=
-                       erofs_dbg("Found duplicated chunk at %llu",=0A=
-                                 chunk->blkaddr | 0ULL);=0A=
+       if (cfg.c_dedupe =3D=3D DEDUPE_ON) {=0A=
+               chunk =3D hashmap_get_from_hash(&blob_hashmap, hash, sha256=
);=0A=
+               if (chunk) {=0A=
+                       DBG_BUGON(chunksize !=3D chunk->chunksize);=0A=
+=0A=
+                       sbi->saved_by_deduplication +=3D chunksize;=0A=
+                       if (chunk->blkaddr =3D=3D erofs_holechunk.blkaddr) =
{=0A=
+                               chunk =3D &erofs_holechunk;=0A=
+                               erofs_dbg("Found duplicated hole chunk");=
=0A=
+                       } else {=0A=
+                               erofs_dbg("Found duplicated chunk at %llu",=
=0A=
+                                         chunk->blkaddr | 0ULL);=0A=
+                       }=0A=
+                       return chunk;=0A=
                }=0A=
-               return chunk;=0A=
        }=0A=
=0A=
        chunk =3D malloc(sizeof(struct erofs_blobchunk));=0A=
diff --git a/mkfs/main.c b/mkfs/main.c=0A=
index 5657b1d..223c77c 100644=0A=
--- a/mkfs/main.c=0A=
+++ b/mkfs/main.c=0A=
@@ -522,6 +522,11 @@ static int parse_extended_opts(struct erofs_importer_p=
arams *params,=0A=
                        if (vallen)=0A=
                                return -EINVAL;=0A=
                        mkfs_plain_xattr_pfx =3D true;=0A=
+               } else if (MATCH_EXTENTED_OPT("dedupe", token, keylen)) {=
=0A=
+                       if (vallen)=0A=
+                               return -EINVAL;=0A=
+                       erofs_mkfs_feat_set_dedupe(params, !clear, value, v=
allen);=0A=
+                       cfg.c_dedupe =3D clear ? DEDUPE_OFF : DEDUPE_ON;=0A=
                } else {=0A=
                        int i, err;=0A=
=0A=
@@ -1532,6 +1537,7 @@ static void erofs_mkfs_default_options(struct erofs_i=
mporter_params *params)=0A=
        cfg.c_mt_workers =3D erofs_get_available_processors();=0A=
        cfg.c_mkfs_segment_size =3D 16ULL * 1024 * 1024;=0A=
 #endif=0A=
+       cfg.c_dedupe =3D DEDUPE_UNSPECIFIED;=0A=
        mkfs_blkszbits =3D ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_=
SIZE));=0A=
        params->pclusterblks_max =3D 1U;=0A=
        params->pclusterblks_def =3D 1U;=0A=
@@ -1837,7 +1843,18 @@ int main(int argc, char **argv)=0A=
                err =3D erofs_blob_init(cfg.c_blobdev_path, 1 << cfg.c_chun=
kbits);=0A=
                if (err)=0A=
                        goto exit;=0A=
-       }=0A=
+=0A=
+               /*=0A=
+                * turn on deduplication for chunk mode if -Ededupe or -E^d=
edupe=0A=
+                * not specified=0A=
+                */=0A=
+               if (cfg.c_dedupe =3D=3D DEDUPE_UNSPECIFIED)=0A=
+                       cfg.c_dedupe =3D DEDUPE_ON;=0A=
+       } else=0A=
+               /*=0A=
+                * turn off deduplication if not chunk mode=0A=
+                */=0A=
+               cfg.c_dedupe =3D DEDUPE_OFF;=0A=
=0A=
        if (tar_index_512b || cfg.c_blobdev_path) {=0A=
                err =3D erofs_mkfs_init_devices(&g_sbi, 1);=0A=
--=0A=
2.34.1=0A=
=0A=

