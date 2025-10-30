Return-Path: <linux-erofs+bounces-1306-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 54298C1ED77
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Oct 2025 08:49:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxx7x6TJqz3bfN;
	Thu, 30 Oct 2025 18:49:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.132.183.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761810541;
	cv=fail; b=EJLeSWYhhvFVzgiijOXS1yMAP51BSAZ28V0qwAa9F+/lvnYgn4mnv7Rn1VZQrmWOSoO93bJkp0igbgAJpXxoPDgLX4Z7f7Y/MNZmoFLKhV6/gyV29WeOxkoYHKSTaXBicO+jLrN3UbxqR9UDJDiTCkQrWGSQ9qW3PXkcgrA5PUdbiTsqPGeqqJZSfLMmyTmgd+j5EQDom2anecMOm+4WC8JlM6ZzMqluWoM/rb04UJy6yIoipYGgO6Z/82kaHElo7YSpAJBfAM2O1c6IPg6hwQzuQSafSk+Vr9U6LS5shMSuyuCjrvTSmjTLc0YtdY3DkjDaE8Y0a879tBljIhhVeg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761810541; c=relaxed/relaxed;
	bh=QtlEYp7Mgg+BjWPf6oR4hYH48MEGDJoOG2bgqAz6SRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=j8kCRIVnBy2v1kXfbweK32J7dodB/7vD9RsfiUlkQLaQvcz66mIfX7wozLLQ8qfeQnaDO4ms5V6LJrIYE7vbdcAzvIcVyQgtTYZDY2aWmNfsE1XzwjuetMurdaKgLf3nEzF3W+ZHiDP50w9zLq9Fsklt6ejutfxG58/9YcKF7s6kAIyqTB5wdxWlrQmQS++JHQ0vI0T2xl24WzaUvw9MaLpHNumXe2sYiIo4Qs5CAN7sgJABfUFVy2mXTQITBJAwO8cbXwcoItMljp2zLfH9/VuyBJdW8SNwFtuEftYLfMXdt7L+3c56fVOp8w2uZaRO4/2rQS5Gs3wZe7cAeqdjxg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=jAdGPiUQ; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=jAdGPiUQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3551 seconds by postgrey-1.37 at boromir; Thu, 30 Oct 2025 18:49:00 AEDT
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxx7w2vsGz30V1
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Oct 2025 18:48:58 +1100 (AEDT)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TM8PVa010897;
	Thu, 30 Oct 2025 06:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=QtlEYp7
	Mgg+BjWPf6oR4hYH48MEGDJoOG2bgqAz6SRo=; b=jAdGPiUQnHOyD7mTg3rDJZx
	w7V5F8Al0bBx1FUeq9TD0iX2EpY/WGu+vhYaet98C4iLyP5ldpGrI+7BgGwka7eE
	B18M+2gem1sPzBCS+eFBxAkoz3RkUyRKn4VDN/jwBX//HBrLPcS0E7fCVtBEBGhl
	ddd2COZCfAZ/nYDIhKs6BUbaHJbMnYIWGwFZ4450PRzr9/u5JW+W+wNqY/OL/3GF
	ltdbuTCcksbjGWjUXR3dk5kFhvnBkG6IshHk2Gf4S4t1vgyeJLmnWYPCIJwvqCgI
	/e8hLjLi6iFIMFeZSAa/ruQ4L971UiXTujhD8QXUpPHAnfXeT/rZnnC/N1SfMOg=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012065.outbound.protection.outlook.com [40.107.75.65])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4a33xnt9pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 06:49:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWVlR9LSmW5eFfcb5fs4AedVu0v5On9fV/ZspjYnjy32M6933y2TZSgCFvVl1v5KoeAXiBs/yTDtGU/1UM5Mktv7nghh9TevxBvbqs04S0w4V/TmoBmCYR2l/jsbixv5sD6snIh9KgYTSVVZv4vPqNjOwsNnQZL+gPYRpc8paQNfxPKYztUPlcdfBxGEq49L41HLE09YxJaNHifUEwIpANZqrECVrVVU6wCl7W1ddbr1ledNHf4Y/00iawwErRilH0wTDObhda4sgzTdyO9Kces7AEgFG8cb1xtnJX3CmKxA0tjKo3d7Jp3TX4heo0rbi8tNoa/9r8KhBI+l5hkmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzMTRY1UBtOHusOtzRuFTUSPqZceA+0LB1wZTBuNvaw=;
 b=ZtPeWHKqbQ8x85ZwOKz8cpDyG1V1hnzpfCXR2RgxD36S5S118UWtQ5EcwIcCFsv4WqTAPMed+GKWle5153GxlOsTPgYm/uTbpuUwJjhQCMKO0NaQsKeZbVc7MfZ/RpYdwQpeD6/Am/u5ksv4T5yUgCC+HEqiKvalIEV9v5SEAaQ4k3//zNJo3Aoy+4V6PCIe8wdRdr7sBavtqhDnQQE/6vlf61ZETDQ8Npd9jB5RJiSbHi7wQk1vIPHJJaPsHz1pLuTFm+F+uqb1dpNXz/5OKbymyg9P1IEp8zGaO133rB6c095jMPDyaA/awuTtXBePF0soVqesMJMM1CO710olBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by TYUPR04MB6814.apcprd04.prod.outlook.com (2603:1096:400:347::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 06:49:24 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 06:49:24 +0000
From: "Friendy.Su@sony.com" <Friendy.Su@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v3 RESEND] erofs-utils: mkfs: Turn off deduplication under
 chunk mode with '-E^dedupe'
Thread-Topic: [PATCH v3 RESEND] erofs-utils: mkfs: Turn off deduplication
 under chunk mode with '-E^dedupe'
Thread-Index: AQHcSVPdF1BTUU4JLEOwWHHefnpchrTaPokg
Date: Thu, 30 Oct 2025 06:49:23 +0000
Message-ID:
 <TY0PR04MB61910809A139F90D72A84DEEFDFBA@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20251028032809.1371395-1-friendy.su@sony.com>
 <20251030041525.2094223-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20251030041525.2094223-1-hsiangkao@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|TYUPR04MB6814:EE_
x-ms-office365-filtering-correlation-id: e8511e98-771e-42da-913c-08de1780762a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NGhTTzFUQTNFbDdvQ29kdFY4QW5qZjJ6QTJOWUhrOVZBU0d3djU1NnluTGdm?=
 =?utf-8?B?Y3ZkcDJTcEp5TlhNeWFwamRpNkp3V3RtbGhpS3NyQmR5bEZmV3c3cUVUTFdk?=
 =?utf-8?B?bTY1bTlnRjNFUzdoRTNpK2pMT3FkN2tQR0JYWDJsa2p6VjlRNGMxZzNyS1BD?=
 =?utf-8?B?MHdJbk5oRlVPdmhsUzM5Qi9ZSzBIS1c3bEw3QnJGcGY3cE9TVGxPWE1kN3dP?=
 =?utf-8?B?cEdwK3VuT3R3bTVYS3g4YUYzeDBrd2JBVXRXUU81a1JmSkVod3ZwQStGd0o4?=
 =?utf-8?B?alE1MHdCcDZLakxiUXNrQWtGSXVFUmlDMG03MC9PajRNM3ppOERVbDNwRmlI?=
 =?utf-8?B?YzhUSXZTVFNidWprL0Q2Yzhhb3A0T2JqQUhjeVp1a0tKMUdtcmhwbG1uWDNx?=
 =?utf-8?B?Qk5WL2tndDJJVVhmS2RzTEtmOTdxRzVwMWw0VDc2TUd5SWpZWkt5U2xhZlU0?=
 =?utf-8?B?QjdJZ2NaaU9xM1NwSFpFTWZRYThZT3NBL3F4MWh0WmsrbU1nZWE0ckxMTUVQ?=
 =?utf-8?B?VWE2eng1QVV4YU9rbHNZRE5UcGVpV3d3ZlgvTnRyRklmNmlBcTcwT0xjcXBp?=
 =?utf-8?B?YWRGZEs5WDRhRC9iZnd3eW5BemVUbEczdXhUWWZrQStQQmZsTGNLYm0rejU3?=
 =?utf-8?B?QmtMUXBoTlVEOEo5Z0FiQ3pxUjN4Y0EzdHQvL0tMb212elBCakd0SWUxT011?=
 =?utf-8?B?S0hQMDdwY0duZmhNa1doWUtocDZTck9tUWRyVkNFQVdaeTdia3VRRlVJY0pY?=
 =?utf-8?B?V0RrbWc0U0NUbVhCTzd2MUNlY0NiNDBobjFHaGdLZ1htMnp2cHNMTXFkcHZC?=
 =?utf-8?B?ZUt0SENYcCtLU2ZNSlM4YTJnSmFlYm83Vm52UTdwRU1EaHQxMHZMVzUxYkFk?=
 =?utf-8?B?NWZSYnAybEFETS9VZEpNTFZUd1I0bEdOM1VFK1V1TExiVWJhbGVwRmdCWHVR?=
 =?utf-8?B?Um5udWNQNTFXanZ2MmNKTmFEVFBKbTNjTEQxeHRMTXFtRnYxSEdySE1WNnkw?=
 =?utf-8?B?SDIvK1oxQlA5S2JQN0JkTHEwbzNhYW9Wakk2emVKSjYzMjRPNSt4WXpjckxs?=
 =?utf-8?B?Q3RVVndaQmlOS1JWTzk5MFVDZW1tQm1KWHBwV0VTVGUzazU1MXp5MEt0NmRm?=
 =?utf-8?B?S2FiSDBlVGc0cXJHVFpJRGRkdnZWSmp4c0pocDFESWpEZXRlMkVSZlpWak5X?=
 =?utf-8?B?YzRDMkxhWHFORUJ0eHJzQm9kenJpZHM0OWxRV2tYZUprVzd6azVWekJmVGdx?=
 =?utf-8?B?QmVSMld0QmNQRFRMdVlOMk9OTE5PT1VzZy94TDZ4c1JFQjZnWTJ3YkNwZ0VO?=
 =?utf-8?B?NTRqS3I5eEF5QWZWWkNyWnMyeGpnd0ZkUUZtazI2K0EzUTFmdTRhSXd2YTNk?=
 =?utf-8?B?L1RTU2ZUYmFCem5OZkZJbEsxR1B6QzBBWElTSHNDMDFQRDZrNXZTMFlINW9H?=
 =?utf-8?B?Vk9aSmZESDdlSmdzYXhvTWhYQ0dFVDZOZkQzWUxIRTBqTytLTEoxZlN3Y1Uz?=
 =?utf-8?B?cFozRUlzWlZtc25WVWZsSUZGbVRhN29kYzk5UVhzZmpab3g3QTY1bXpGZlNS?=
 =?utf-8?B?WjlwK0tISWFBZEM3RXd6UzZFanppS0ZrSC80cmYxRGpDZUdnUnFUbzRmRFBv?=
 =?utf-8?B?RHRYdVNnTlAyeUxuQm9LT1RvNXBaeTRYQ2tBRkpMZk1yanRtTXJFZ3RkVjhn?=
 =?utf-8?B?Njd3WFArWjZlazltakFTdXNWNko4eTBJMUZsemhBdTF3YXpienFVRlhiOXk4?=
 =?utf-8?B?d0xBRzVJTU9WOWlBMWdoSE00b1d1Tm1uQ2NGbWhOK2QzOGhKZG04TWlkdjVB?=
 =?utf-8?B?T0RUZUt0cGlPZUVuUEVHaDNGdDZzY21GZmJPbjZwcmQ4MXhRN3JsUmZ1WlNK?=
 =?utf-8?B?TjZLWDVET3RYNlhGNHp6UTIzdTNrc1dJUFF5UjVEdFBsQVEzNGU5U3llRFJn?=
 =?utf-8?B?ajBiblNMc3gra0psQlNhQkp5RmJBQnpyWjZGSVlQemRPQVlGYmp0VHhGd3Nq?=
 =?utf-8?B?NW1sOFNkZTBZcnRNZjB2akZjdmxPV0xFTGVkMFEvV0p6b2xlcWUzOGxxbEx0?=
 =?utf-8?Q?yEX8Nc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHNGYzNmam5mcS9JZWNDTi93QkNTZXVxQmd1OGVrRkZpbXdWbithVndLZ1R5?=
 =?utf-8?B?NGhFSmxrRVVLKzdycVhtbGNMbUw2RUlNSVpGTVlsYTN3YlduT00yWERvWGNU?=
 =?utf-8?B?clQ1RHV6UmZIZThHczR2SHBpaE5sd3FZOWZJbGNzclI2OWhiNk9XU3FTbTAv?=
 =?utf-8?B?VENVVXd2aU1CYUVPNG9IVzhtekxwRDhSUi9FMzRBeEw4Vy9WMXc1bFUwbm40?=
 =?utf-8?B?L2lnSFk1NVFIc2Q4V09iZnRzZ3o5UVJmZWVZOTRpZUpEZ0lWRHdJOWxoSm9r?=
 =?utf-8?B?TGlnbkhBWWJlR1Q5U0N2RWxYTzBUdTBRMnFWV2x0Wkl0c2JadVhFaTE3cjBt?=
 =?utf-8?B?ZW1MOVNCZVczOHA0N0R1Y2M4MFl4UWR2SEpudHNzWUQ1WUV5MVZqVW5TNHNU?=
 =?utf-8?B?MTZ4UGFwbGRyNzBRbjNieExNUHg2VkxKOXVGa1hyQnNLNnpWeVpBOFFLbFBy?=
 =?utf-8?B?WDRlOERlb25zZ1Y5QjJJSTVNaGxUeTdzQWc5WFJjR201V2Y2ZHpaaE5VRjVE?=
 =?utf-8?B?aXQvMmFQSGR4VXNScnQ2NkZlTUZueitkdENlTzduNVgySHhCN0VGclM2bGtJ?=
 =?utf-8?B?NlZzSG40VVlxaFFZNlV4T1ZuS3c3a3U5LzkzdW9KZlF0UDBuSWJ1OWZ5dUtB?=
 =?utf-8?B?QXJVaVFuWGQyb3FwMzZNU0J6YjRSSUhPaWpEblNybWJpNWFsNFo1cXRLZjZm?=
 =?utf-8?B?ZWc0WG9CbkZJeENmd2JYZFRxOWw3RDVsTlh4Y1I1TmNnNGVLNjgwLzliSXk1?=
 =?utf-8?B?aDkrLzZVelkyai8wbWJNWEtNRzd1RUtUWEhIMmh5bjlWR2o2TDJpT0Y5enA2?=
 =?utf-8?B?OU1PMkEvUG1FZ3lXTlpsUGVlbVd2SU1qQmFxdm5INFNXRjFaRktack9FUlJG?=
 =?utf-8?B?UEJlQlNzeVBpZnh4TnM0SzBCRERxVk1vS3hrOHUyWnR0OUV4SU4yTkFVL1FV?=
 =?utf-8?B?TXo4RVlRSVNUMmExYmdXc0p4UUhVM2lMdDNLVEVyd2tqb0d6emJ4NXhPTnlz?=
 =?utf-8?B?YUp6UGVWLytDaTdEczQ5SXE2TGwyakd4TEsvUVJ6L3ZEOVdzcWtIdGsrNHdK?=
 =?utf-8?B?RGtTSzRKTk5kOWJ4N2Q1enMvTjhKYjYyTFpyb3FrNFhhNmN5VEx3ZldWNkJL?=
 =?utf-8?B?S3ZBREtGOXM3MExveHV6M1NFYUhkUm5QblhFVmh4YWdldzNKclpDU1FmRmRK?=
 =?utf-8?B?d0tHcjBDYUlrN2tnVTFRSStzTGFhYkk1ZWs5MEIvRmxSWFFyTnVyQ1VOaWRH?=
 =?utf-8?B?djB4cEhqR0JDaW9pNGkrc3h6VkxsTnVHL1QvekpWakd3Z1p2c2FSVytVMDln?=
 =?utf-8?B?WjlQbXV1bDNxRzV4WUhxREYrbWNFWTZYNTBQTS9tREZLMmFWWXpiS0xnNEhy?=
 =?utf-8?B?QWZ3ZTJqUGlhK1hPakZiZmo4YjUxWWF6QTJaVUY4bnYvbk5YWWU4alJoMk8w?=
 =?utf-8?B?djdxd1B6Q2g3aGFpekhHbnF1OU9lNDVtNnRqUGdCOGdFOGRQdVdFNFZEUzc3?=
 =?utf-8?B?aGpLR3NoNXFvQ1Z0OXFuejM2dXd4ZUJ2TFYvUXNRMCtJdFJuaXR0dnp3OWJL?=
 =?utf-8?B?aDgrK1dmcjJ2Si9ORnAycTNzUDV5ZDhrUmd0YnVBQklkMytqSG5tRWNzdUM1?=
 =?utf-8?B?SG1tWUFjSWhsb1d6ajBnczRBNW5YUW1rT0tLNFVOcTBjRm5kZUhoemhQSUZx?=
 =?utf-8?B?bEhva1lHZ0tua2FmeHdwWk5DdHNuMVUramhMU2JqWkZWbkRoK2R1VFZMbXFX?=
 =?utf-8?B?UXNJak1JaWJFNzFMWFdWeWtRY3ZvRFl4OVNUK2oxTTJRdWRORzlyVk4zTlhH?=
 =?utf-8?B?UldDOGdXRThheWd6MUNvayt0R0NKUGR4dzR0eERLZUhJaUtQcFR6bnRlaGtx?=
 =?utf-8?B?eUVDUFMva0xSMGx0S2dmMUMzZHA4akxWODZNcUtsVy8xVmVCeGlrWXlVWFRR?=
 =?utf-8?B?OUFkb2dWSVBxU3BUZDBDNCt4ZjJtYVFWQllnTUF6cjdxVjN3NzFDK1E3Vk1l?=
 =?utf-8?B?YUNHdCtERW0zblZxTG10WU4wdVpBTzUydVNLVFV2YzNwNVVnZTNqN29mT2w0?=
 =?utf-8?B?U25UNitBd1BzaWd0b0V6aU5mZjZaaEx6N0VsYlFtenp2WjZpTGRYdnQrRmo1?=
 =?utf-8?B?MmpkYll1WE1ZZmhhQzd1OEtJYkpyTXo4MjRjQTQwOUpNNTh1S3NSTlpHcmwy?=
 =?utf-8?B?ZVE9PQ==?=
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
	TSyYWjJisiPhc1UkEIQLPEImSPZWLAPJEIiLt6lSNPprcP+dgJCcKNQ/+QGZL3Uh5KVtuOXef7F4LbfxqLCeqoEdtYiB4cixyukRi3JnUXIInoQ4zQnemX3VgcWIuCl4L/j8Ihx+Dg514D+JpYpjwjuJPoXMKhK3Ycv3fGMta5F9dSx9RaNnYRqUgeLF1LS+euw588brBb3krkuWPRmqAHy9b3X7uk9sKTfD0uo9v0FGm+v7rKWQi4j+rujVYtDw80E+6+6zgqiA5XC9CbHiaOGMEBvObj5d3IJo3JgWXTihAlRmUt1xyXdxb6zZUZAouts0Z6LuRKbSrvAsCh7q4NZRG6bv9xwy0mdIXv5cy72VbfURhLwawHA5PC7LxpfHvjOd2Kp19/vJDmzbMIQ/VUsqA+5L60KbJZxEAffpMIr/fuytCZVp+rFb+DE7otn9MumNmJsvACITgtbH+IKSXn4eBRs/f2TsuvHATdUeKn6J/tEEd6fPVrKNPScAfjBg7FhHGQSmfdIAKU4ie6ljUdDXPc3FoIIts5I75MW7yE1bWTGBoKDuU/k6MKijGTworduInrUD+mUa+24hZp8LZ8jTR38KaV8sn4wxxVKJagbEzI+SRKbc1OySGwK7yHsD
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8511e98-771e-42da-913c-08de1780762a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 06:49:23.8876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pBla2bkREYD1cx9l+CxbEgJ5YtT917hT96shzjg4lo+RuCvMKpbWFsIUfrDUmjQlYXkd7vyMXXdJgFJiMDMQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6814
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: iYxhIe1N1w1zjJiS5-Hgv6lnh-qfRoxa
X-Proofpoint-GUID: iYxhIe1N1w1zjJiS5-Hgv6lnh-qfRoxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MyBTYWx0ZWRfX/ybWPIyXHLBO Rdz/YznNg5h38K94ozXuX5t4Qz1/zPsTgzZCBqMN89rfILAlqm1y3TZPANdfbICyfvlYG/u+zjF EMirkiDYkK9aGBGgZAquFCa0/XcWi8jJEn1f0DlZOHhhkDrDMUSL130SzsiMw+SwVi7/54l91rm
 lpgrn+CKNG/+9W+GjdNDfso1lZ74/U5Avf5QcbYZ8D8rXdc79sGb8Ct7ZZJmDc6iCaSp5Vuq7Eo UqvB7Wxk2LKJ+Pzt8mTgZpW5yybvii+wzJJXWKutNNNT5+7xsNFkWawarLrtWmTTwSc9IheEmtc QFqbLD2+dBPBELuDM6ckxYkjYjJ2zlfGSU289ACVu7osC21TdjuxRSO+Fl/Q7tM2iJg2CmjJWVy
 7EYqcYhMZBfK6ReGwiFJZmivIIvDEQ==
X-Authority-Analysis: v=2.4 cv=S/fUAYsP c=1 sm=1 tr=0 ts=69030a81 cx=c_pps a=t4Jo6+OKmEhDu5+t5XbuXA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=62uomysQcIP4y0fKlGIA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Sony-Outbound-GUID: iYxhIe1N1w1zjJiS5-Hgv6lnh-qfRoxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Gao,

Patch v3 works.

not chunk mode:

-Ededupe -> deduplicate
-E^dedupe -> no deduplicate
not specified -> no deduplicate

chunk mode:

-Ededupe -> deduplicate
-E^dedupe -> no deduplicate
no specified -> deduplicate

________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Thursday, October 30, 2025 12:15
To: linux-erofs@lists.ozlabs.org
Cc: Su, Friendy; Mo, Yuezhang; Palmer, Daniel (SGC); Gao Xiang
Subject: [PATCH v3 RESEND] erofs-utils: mkfs: Turn off deduplication under =
chunk mode with '-E^dedupe'

From: Friendy Su <friendy.=E2=80=8Asu@=E2=80=8Asony.=E2=80=8Acom> With '-E^=
dedupe', deduplication will be disabled even in chunk mode. This is current=
ly mandatory when mounting EROFS with DAX. Deduplicated chunks are shared a=
mong multiple files or between different


From: Friendy Su <friendy.su@sony.com>

With '-E^dedupe', deduplication will be disabled even in chunk mode.
This is currently mandatory when mounting EROFS with DAX.

Deduplicated chunks are shared among multiple files or between different
parts of the same file.  Kernel DAX map got wrong when map them.

[    2.031496] WARNING: CPU: 0 PID: 1 at fs/dax.c:460 dax_insert_entry+0x36=
e/0x380
[    2.031978] Modules linked in:
[    2.032173] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc2+ #111=
 PREEMPT(voluntary)
[    2.032688] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), B=
IOS 1.16.3-debian-1.16.3-2 04/01/2014
[    2.033291] RIP: 0010:dax_insert_entry+0x36e/0x380
[    2.033591] Code: 59 fe ff ff 48 8b 30 b9 09 00 00 00 83 e6 40 0f 85 70 =
ff ff ff e9 77 ff ff ff 31 f6 90 0f 0b 90 85 f6 75 ae e9 34 fe ff
ff 90 <0f> 0b 90 e9 02 fe ff ff be 09 00 00 00 eb e3 0f 1f 00 90 90 90 90
[    2.034654] RSP: 0000:ffffb93fc0013b88 EFLAGS: 00010086
[    2.034948] RAX: ffffe124441dc140 RBX: ffffb93fc0013c78 RCX: 00000000000=
00000
[    2.035339] RDX: 00007f310337c000 RSI: 0000000000000000 RDI: ffffe124441=
dc140
[    2.035730] RBP: 00000000020ee0a1 R08: 0000000001077050 R09: 00000000000=
00000
[    2.036120] R10: ffffb93fc0013cd8 R11: 0000000000001000 R12: 00000000000=
00011
[    2.036513] R13: 0000000000000000 R14: fffffffffffff000 R15: 00000000020=
ee0a1
[    2.036912] FS:  00007f31026ad940(0000) GS:ffff90436812c000(0000) knlGS:=
0000000000000000
[    2.037352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.037669] CR2: 00007f31033c2216 CR3: 0000000001d17006 CR4: 00000000007=
70ef0
[    2.038062] PKRU: 55555554
[    2.038216] Call Trace:
[    2.038363]  <TASK>
[    2.038486]  dax_fault_iter+0x286/0x6a0
[    2.038704]  dax_iomap_pte_fault+0x17f/0x370
[    2.038950]  __do_fault+0x30/0xc0
[    2.039153]  __handle_mm_fault+0x90a/0x15a0
[    2.039391]  handle_mm_fault+0xde/0x240
[    2.039607]  do_user_addr_fault+0x166/0x640
[    2.039853]  exc_page_fault+0x74/0x170
[    2.040087]  asm_exc_page_fault+0x26/0x30
[    2.040319] RIP: 0033:0x7f31039389bd
[    2.040519] Code: 08 48 8b 85 68 ff ff ff 48 8b bd 60 ff ff ff 48 8b b5 =
58 ff ff ff 4c 89 f2 48 03 33 45 89 f7 48 c1 ea 20 48 89 b5 70 ff
ff ff <0f> b7 04 50 48 8d 14 52 4c 8d 24 d7 25 ff 7f 00 00 4c 89 65 80 48

Signed-off-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
In the long term, `importer_params->dedupe` should be used
for inode chunks too.

 include/erofs/config.h   |  1 +
 include/erofs/importer.h |  8 +++++++-
 lib/blobchunk.c          | 27 +++++++++++++++------------
 lib/compress.c           |  9 +++++----
 mkfs/main.c              |  5 +++--
 5 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 1685adf..525a8cd 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -41,6 +41,7 @@ struct erofs_configure {
        bool c_dry_run;
        char c_timeinherit;
        char c_chunkbits;
+       char c_dedupe;
        bool c_showprogress;
        bool c_extra_ea_name_prefixes;
        bool c_xattr_name_filter;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 60f81d6..e1734b9 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -17,6 +17,12 @@ enum {
        EROFS_FORCE_INODE_EXTENDED,
 };

+enum {
+       EROFS_DEDUPE_UNSPECIFIED,
+       EROFS_DEDUPE_FORCE_OFF,
+       EROFS_DEDUPE_FORCE_ON,
+};
+
 enum {
        EROFS_FRAGDEDUPE_FULL,
        EROFS_FRAGDEDUPE_INODE,
@@ -45,7 +51,7 @@ struct erofs_importer_params {
        bool no_zcompact;
        bool no_lz4_0padding;
        bool ztailpacking;
-       bool dedupe;
+       char dedupe;
        bool fragments;
        bool all_fragments;
        bool compress_dir;
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index a5945f8..3b1c97b 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -8,6 +8,7 @@
 #include "erofs/hashmap.h"
 #include "erofs/blobchunk.h"
 #include "erofs/block_list.h"
+#include "erofs/importer.h"
 #include "liberofs_cache.h"
 #include "liberofs_private.h"
 #include "sha256.h"
@@ -64,19 +65,21 @@ static struct erofs_blobchunk *erofs_blob_getchunk(stru=
ct erofs_sb_info *sbi,

        erofs_sha256(buf, chunksize, sha256);
        hash =3D memhash(sha256, sizeof(sha256));
-       chunk =3D hashmap_get_from_hash(&blob_hashmap, hash, sha256);
-       if (chunk) {
-               DBG_BUGON(chunksize !=3D chunk->chunksize);
-
-               sbi->saved_by_deduplication +=3D chunksize;
-               if (chunk->blkaddr =3D=3D erofs_holechunk.blkaddr) {
-                       chunk =3D &erofs_holechunk;
-                       erofs_dbg("Found duplicated hole chunk");
-               } else {
-                       erofs_dbg("Found duplicated chunk at %llu",
-                                 chunk->blkaddr | 0ULL);
+       if (cfg.c_dedupe !=3D EROFS_DEDUPE_FORCE_OFF) {
+               chunk =3D hashmap_get_from_hash(&blob_hashmap, hash, sha256=
);
+               if (chunk) {
+                       DBG_BUGON(chunksize !=3D chunk->chunksize);
+
+                       sbi->saved_by_deduplication +=3D chunksize;
+                       if (chunk->blkaddr =3D=3D erofs_holechunk.blkaddr) {
+                               chunk =3D &erofs_holechunk;
+                               erofs_dbg("Found duplicated hole chunk");
+                       } else {
+                               erofs_dbg("Found duplicated chunk at %llu",
+                                         chunk->blkaddr | 0ULL);
+                       }
+                       return chunk;
                }
-               return chunk;
        }

        chunk =3D malloc(sizeof(struct erofs_blobchunk));
diff --git a/lib/compress.c b/lib/compress.c
index 1a68841..c90369f 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -636,7 +636,7 @@ retry_aligned:
                        may_packing =3D false;
                        e->length =3D min_t(u32, e->length, ctx->pclustersi=
ze);
 nocompression:
-                       if (params->dedupe)
+                       if (params->dedupe !=3D EROFS_DEDUPE_FORCE_OFF)
                                ret =3D write_uncompressed_block(ctx, len, =
dst);
                        else
                                ret =3D write_uncompressed_extents(ctx, len,
@@ -1381,7 +1381,7 @@ int erofs_commit_compressed_file(struct z_erofs_compr=
ess_ictx *ictx,

        if (ptotal)
                (void)erofs_bh_balloon(bh, ptotal);
-       else if (!params->fragments && !params->dedupe)
+       else if (!params->fragments && params->dedupe =3D=3D EROFS_DEDUPE_F=
ORCE_OFF)
                DBG_BUGON(!inode->idata_size);

        erofs_info("compressed %s (%llu bytes) into %llu bytes",
@@ -1743,7 +1743,7 @@ static int z_erofs_mt_global_init(struct erofs_import=
er *im)
        if (workers < 1)
                return 0;
        /* XXX: `dedupe` is actually not a global option here. */
-       if (workers >=3D 1 && params->dedupe) {
+       if (workers >=3D 1 && params->dedupe !=3D EROFS_DEDUPE_FORCE_OFF) {
                erofs_warn("multi-threaded dedupe is NOT implemented for no=
w");
                cfg.c_mt_workers =3D 0;
        } else {
@@ -1844,7 +1844,8 @@ void *erofs_prepare_compressed_file(struct erofs_impo=
rter *im,
        ictx->data_unaligned =3D erofs_sb_has_48bit(sbi) &&
                cfg.c_max_decompressed_extent_bytes <=3D
                        z_erofs_get_pclustersize(ictx);
-       if (params->fragments && !params->dedupe && !ictx->data_unaligned)
+       if (params->fragments && params->dedupe =3D=3D EROFS_DEDUPE_FORCE_O=
FF &&
+           !ictx->data_unaligned)
                inode->z_advise |=3D Z_EROFS_ADVISE_INTERLACED_PCLUSTER;

        init_list_head(&ictx->extents);
diff --git a/mkfs/main.c b/mkfs/main.c
index f1ea7df..4de298b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -376,7 +376,7 @@ static int erofs_mkfs_feat_set_dedupe(struct erofs_impo=
rter_params *params,
 {
        if (vallen)
                return -EINVAL;
-       params->dedupe =3D en;
+       params->dedupe =3D en ? EROFS_DEDUPE_FORCE_ON : EROFS_DEDUPE_FORCE_=
OFF;
        return 0;
 }

@@ -1826,7 +1826,7 @@ int main(int argc, char **argv)
        if (err)
                goto exit;

-       if (importer_params.dedupe) {
+       if (importer_params.dedupe =3D=3D EROFS_DEDUPE_FORCE_ON) {
                if (!cfg.c_compr_opts[0].alg) {
                        erofs_err("Compression is not enabled.  Turn on chu=
nk-based data deduplication instead.");
                        cfg.c_chunkbits =3D g_sbi.blkszbits;
@@ -1840,6 +1840,7 @@ int main(int argc, char **argv)
                }
        }

+       cfg.c_dedupe =3D importer_params.dedupe;
        if (cfg.c_chunkbits) {
                err =3D erofs_blob_init(cfg.c_blobdev_path, 1 << cfg.c_chun=
kbits);
                if (err)
--
2.43.5



