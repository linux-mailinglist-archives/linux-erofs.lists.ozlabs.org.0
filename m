Return-Path: <linux-erofs+bounces-3266-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PSlEiTA2GlVhggAu9opvQ
	(envelope-from <linux-erofs+bounces-3266-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 11:17:24 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A273D49C1
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 11:17:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsWR444C7z2yZ6;
	Fri, 10 Apr 2026 19:17:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.132.183.11 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775812640;
	cv=pass; b=GxaSSDQYOKsl0zyYCSzllxep26N1oPmm9biKIv5Irqs53Vt6HIVm3qzQQHQwyvjTGcyqMRpAgpjx/enQ4fJuTln8oAFZwXnNatcToAPXrI5cpnAJ1iyh/NOSb03nUZgoY5xb8ayAEdGHiqKYKhQVoZ6O9CvGpUhPpW7S9S0iAGHNVauouxhyvmCbzj5P0vhB4kltc/pr+XBlBgGN92V4AfkUWNLQeyN7gHPc+O9SPlyrErTjaTVJEFJMwQdg/ccS3G0Y5W1lrffx51Q5dlco8z1rIdkRnJaPEe6TmXY2+E+NsI3w0+Q+sG+j3AfF+EVV7EwB7vp5eqyXi8/X9zhHbA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775812640; c=relaxed/relaxed;
	bh=F/W9v087oOAeDgsd0BIfsvw+ewACQH3UvmvrIITvbfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TSs14OJ1KsblngunMpUdUhYZnHQC3Btel3R0A3N8ipOCLDnxzy8KxP7RhmtdhMzL3XCttA9OPYJ0zyYLMa+62YiGF8jHxDozPPz9EYBsGP0AdBwZqVg5Ef3BGF4DwZ6InS+IbykvUbPOMh8kgYwQNyYQMHirB5UfYrWLp0DYP7Qdv0rQKlngJBTay92Jvl8459YEXEeZVZ46EpS/5T8XBC96nfoMdW8vldat7+TeCm4jQNVIzevEHa1Ij1L5JklI8DWkHxzeI4PwCn50maZDpvrQ4T42DxnOw7/ufTenHJJNC0kdsvoOjuykmlJ0PSdoRVLL4q6w/9F/BrpqAezcxg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=CJrBmJhg; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=CJrBmJhg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 993 seconds by postgrey-1.37 at boromir; Fri, 10 Apr 2026 19:17:18 AEST
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsWR273GMz2xT6
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 19:17:15 +1000 (AEST)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639Miu9H143378;
	Fri, 10 Apr 2026 09:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=F/W9v08
	7oOAeDgsd0BIfsvw+ewACQH3UvmvrIITvbfk=; b=CJrBmJhgYhxWp8d8Y6TcKQ2
	PdtaaXscnZMcbF1t0yLmSazF/+EER68pWThEX/NxtMnvmtqNbDI6XfygvGw3aA9+
	ElPb16xiBPI1xHXpDRq+WGbYHEmzNVcaMC8jbtmdGMkyXmanKTs2XzbA3Vl5xgWP
	bX5ZRUVfjnD0Dl0KaMv65hPuX2CXaU0c79RCyhMkZ5meU80kPRsgYT3OnC107bi4
	PLGBCJs8x4/Fy/oKr3O7c70rAc20/38fhmMcDreVvmWy50N5xi+j7v+ejby6k/oz
	fel38wORai0/oivm1hoy4V/patORjHGS0zRiSPsYr+mljTXQ4Hv8mh0sOq86z2g=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013057.outbound.protection.outlook.com [40.107.44.57])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4dcmsmdfdh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 09:00:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbctoszCKfy86MU6hilGHC7bxEZuTSkgEUYamKYYdvzlWFi89JdPdbJcPiqMY9uQeEQUM+8Afg9x6NGfokd6R2tchF1SZLRCUuDm784T6bkNHNtogFn++9X7Q5MzWzLyVWjA+T4f6kQnp3xMNj88UhQfu1G3Bh3bUWXAcn8uPVecMwkY9BAj9XSlI+mHFf0q9rac+bNj9H0LCRzeehLuhcdnH1xRXseliVFvyr84YR5nxVSCCBOUrnEZ5+qjHBGc1tgHfhk/ZyzpmFWMyG6du07Wf3jNoiZw0ekRHG7Quu1sFOPQpxuLlbAkzwy02k2Q42WgIshdukpy0ogi8/e4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/W9v087oOAeDgsd0BIfsvw+ewACQH3UvmvrIITvbfk=;
 b=RnICAKf9JkVVt6ffJ0TVEcujJXoO/XOdtyZl9plmo6aj07QeVW+2z/zMLggYbVLaZrARzyViE0cQuhNypbLdO67Ox+ecVLVafChBUcBiZ5YG9UQhiFqiZxB7/FEh688Oa9FO+AxmpqXA8RxMWCXBhk9gOja+0MX/D52WU+2DdABdsCbDZTMt6nlnVjbVx4ECt1fv3wbdmK3ELe2AbCrymX4PTEUKBXC5exgeTb5JI0AeRrard5LhlBdC8gI848VMEpRC+jHjzqJtVQek7johvfjK1soRLF/YHEZemySbq3sBaDqTUeUY60bIuauc5jtAz9UdkbhRrQ86UKJCLvO4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by SI2PR04MB6617.apcprd04.prod.outlook.com (2603:1096:4:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 10 Apr
 2026 09:00:24 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::bc92:94bf:cf9f:313e]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::bc92:94bf:cf9f:313e%5]) with mapi id 15.20.9769.017; Fri, 10 Apr 2026
 09:00:24 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v1] erofs-utils: mkfs: fix fingerprint not set in certain
 modes
Thread-Topic: [PATCH v1] erofs-utils: mkfs: fix fingerprint not set in certain
 modes
Thread-Index: AQHcyLA2mnbpC+bRAEiWDKntmThwz7XX3DQAgAAVkMQ=
Date: Fri, 10 Apr 2026 09:00:24 +0000
Message-ID:
 <TY0PR04MB63283F67989B4A1649F6149E81592@TY0PR04MB6328.apcprd04.prod.outlook.com>
References: <20260410060539.417457-2-Yuezhang.Mo@sony.com>
 <c1514566-e3ca-4ef6-b23b-054f9e1a49c5@linux.alibaba.com>
In-Reply-To: <c1514566-e3ca-4ef6-b23b-054f9e1a49c5@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|SI2PR04MB6617:EE_
x-ms-office365-filtering-correlation-id: 2e159aa6-332a-413f-d602-08de96df9a60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 e1tM+IEZZgz47qEp5CYSV/ew+YKOXfafh3TOQG+e4haJGSklcI1vL1q7YYnF0abT5CmO6EXMfWJzqkJ4R12Z2fY1Tj6ZPbEnplGewLCb9XveZhwWelPnt9Gd9Bkzo9okbSOt0g6+OgWEpBvFSoc1sG9msHfePVQdaDmep2uKGYspldKwwl1qbLwE98A0rnyvwtEHHHOE8D1uAHiPpRewrz3U9WEHKvAgfwHK2MQ0ZYtV2PnZTssPU4LNSkdcVl6atDapoj7Mt6zPsb5g+MJdGI9obScH4gl8wHSHoyPl58GqwCjCIVL5+4yL0m6vWnwxpulG/5dkSzEtCDJkOZQrsrTO2qpWEqgjkPBQgRR07P/nhsfonLmjWV5EUF+2skxF7Af0VTWMIvOUT4e3Vo84+7m1JIMomQuZjnS/QQndMuWblSOXSaeSMC8oxYbKp3GPEA0FQiZ20I3b9wgyk+ZCCpgu1rsRbKmYRo1+1fhCM+g7RzGvuAdbty/gPzJNj04vTQqI7HLuNtwBp108vl/eiUIFV6O+BkkebB8h1v4MKttnerRDa5GMHoxoL4ztGV1eUCOX4a+e4UTJy7cG5X6n+F6SaoMT1Z9Oz85QGiIjveNI8VUNNhpJrgehnP1W4ytwHp2OSN4kF6uF41/N/Qsn5Lmf+mZ9tFcyokBJcRo3cjHoun1cpndDtkb97mvIzKl90bUaz9V2pl/V02qL2VHx10/qSayIUw78YUTkSVyN4Y43UVeADVmT1FZckb3/bI+GcFefIVg+yEM4QaTzYz1te+SJvgxA+Kcleec7zCUnTu4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/55PAqz3B+BKxePgk5gylmxdc6vSK4/oouOXdneweihfBeOjBcUdpe85Q8?=
 =?iso-8859-1?Q?o7sE7umTJLgPgcF2selDIEyGeV7/o/VXF/I9bw6+fRMjabyrD4eiafGg8C?=
 =?iso-8859-1?Q?ltKiR8dyj3ZjQibCpDtoo/2WLGPHtBUtX7Rfj49zOh3xsHicLg/yUaW8jZ?=
 =?iso-8859-1?Q?oKgScpT2ZUMTuowV2vCTNXc8/WWRw74W6SSv9ts6+/e4Lu8nYDEzWFgIbW?=
 =?iso-8859-1?Q?ZnQ0X9Sj/2mV0nXHr5cTl2oULclKTJhSxpcttHXNsQxDgXxQR2J8TSQ397?=
 =?iso-8859-1?Q?Q/un+iVTw77m+ZfoMTOT169BZDtKXHZuPVPJ7E1sKKQC4ZBhZtOWqTR8JW?=
 =?iso-8859-1?Q?3mwAr8psF7gQmkJCqOxbZlcRfQlfnEdAfRC8JoLsQTfBGPdHuLIftKEuj3?=
 =?iso-8859-1?Q?/OZ7hUBKqy5adLP7W7qpM3l64j1GgW7Tt8htZd8wVnp3bPZmUYNbyKytPy?=
 =?iso-8859-1?Q?KN/SFHdiXxul7nujDgrbHSJkk17TV44ld5GNw/hVPYoKKMslGkWFvyZDbl?=
 =?iso-8859-1?Q?vquK+PFhbWOxcN7xYQrkPrmcFjqknwc3rO0WI03Njlz2zS0kTqH3seh4ca?=
 =?iso-8859-1?Q?Bz0+54rUgabf8XQ+oS5luskDK27tyUIJGP8yBp287hRLQK1UPUrHXV2s/l?=
 =?iso-8859-1?Q?MX+SUEfdekDERRH6GWI3HMG5ZMwGkzfZ7ginf4C+CJ+/rM0x30Cdqq6XC/?=
 =?iso-8859-1?Q?kjLH8/KKUzQzQqxdojAz5FAdZkUt/dWVeqqI+jPQfjCCGC6f9gvEZb/ll3?=
 =?iso-8859-1?Q?85rPagwj+oI34HjDTDiIDmMkQiuU9u4d1gc7D0zH6q6SHgc2CH6yjnx3CV?=
 =?iso-8859-1?Q?8naF7quhq/1f2jP99heUemt+6tb4Dhom29ZRwdyix/D2/gJhXWPwbaK0oS?=
 =?iso-8859-1?Q?VuoMCWv+BOVX2TFhRY+y3r/ktA7irywnqwl2c8g9vncxFyl9oqhwn1M1ET?=
 =?iso-8859-1?Q?c2p8iSjnfL+vaM6t+C93U0DZVMd0AD7z+RtkyBls6W6CUoGDXCYR5IoV9b?=
 =?iso-8859-1?Q?OT9icyce1wOepmsuZphVUpxBPQnlH/TcLakvpDOfbl7HEvEIbrgvEBE2o5?=
 =?iso-8859-1?Q?aVeJrrqmTsuRUdFJkYegNT/Cycb+BvCG6/pjTU11W74hIfVux0kvZjJlwG?=
 =?iso-8859-1?Q?44rEGpkznr9rzp/XXkFxHcQ609e1C1+pPUOng0mLSUABLorQ7mq9voTIUy?=
 =?iso-8859-1?Q?jZ1kXQAZBRFHVR9G+7xvlk6bBFhq0LS0uqwIgog+aWaOuAP9td6SU+qYJI?=
 =?iso-8859-1?Q?q/rqpbi+cokwtinn+o9eoyZxLTFy5sOXT8U1Tf08xKikJgDWXVkZUMp/TE?=
 =?iso-8859-1?Q?sZ81eF/HQmcR0oomNYQQXtEDV/+ePrQxrXdQnZblHwm4ZObvQlcf6RQl+k?=
 =?iso-8859-1?Q?oXyNqRdkL12m5c+bpPcaTDA/4PxAvDJIaU6yKcpARV0AtJG7ksD4z77dlv?=
 =?iso-8859-1?Q?k6ZDhZ+Ts0kSf2ZeHWHTi4CU1SahovgesRGJD5GPXjaFemKd2ZA5dk7vFP?=
 =?iso-8859-1?Q?xK/CvVNv+A363Te14xHPBy0zosRCziLBhGXrgWGKeXtNTQBoteyx6AAhpB?=
 =?iso-8859-1?Q?VxZG87NPBQzdqJCQYrhJZxUH3eRG+UMfm8xLOi8zpePj/gLdnTF7oSfXyq?=
 =?iso-8859-1?Q?knt8PbsIknNpXSctD/vXwoZX/hUN+UJgF8I04zRde9do+ij6VM0kJRput3?=
 =?iso-8859-1?Q?d3IYo3nRMpQLZBfO9UUO97yZktaTzLkIXbzgmY5EOIPL11Jz3R+ZgMHDUA?=
 =?iso-8859-1?Q?6IqIeShpbN+kgb+Quq2WDAeEhUGO4/maWzZWCsU8Sf6eRYWthPmjlJyBl5?=
 =?iso-8859-1?Q?VidGcNd3nw=3D=3D?=
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
X-Exchange-RoutingPolicyChecked:
	URqGFuQCVWPaV6bNE7MgZ8GzgxFkKywZag1SXKLXDNT0XFwzH0ndoKa/1K/QLotm7u68bf/m659oEBjr0aEHJoarCDi7tqCT56yizxcC26IlMFV+BTrzDhx8zqG0+bOlZwCNytRbfATt8EbAQA0f4apBEv8l+D47RsABxHN8T/y8jf6u0zJwZFOO9zQP4xySFey7FnBDL/QxEOOOLnRymR+K4ZrUBQ/nkj8rIVv9xQd0RvPwpdmgQYjrywvzDp6Morhhbsuj0B1xAv0UaCbyZmtWPaGJxo+04b5GShL9IUcnATEHtc015cV9BwJiBEeR/EDk+5A6vJteZOcDeE4Jrw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hV3ATM1JTId11CxIUuLWNWmcUudzebX1M4mcuwbxx2UQEAIShe7aNiUm3kGyLYf6ZX/Cr6V/ezgCZspzdgllLsnrmpJsQATiHn9RDxFsIs3PU5UN8lNmz4PU4x3xApycrXuRnJuiAHoKNmP3+OfqE2SD5PUyocnnO3HQF6PHAmTG1PP1rokwn/Y8rj448eLLiFwYFDDhv5RkS4vU9fAQbIIeu+DPiZ53L114AQjmv/ob28zBuNrb4IG3UVLh1I2uTiHfk3Y/sj0JX/pXdaIQHTbKsDQf950RM5r4Q0OU1T8yStBL0mKMpihp6tRuaedsR9vA/IUmdGs/rk8rSVpEAB3swCERrClru4MQQWaN/w1HdQ3pCScTf6SDy/y4fmKFWRlDnoSZo7zD80UZDSxlb7usg8K17CjGQrPsQZ6RtWp+P1nYHhv4XP5Y1nz6MqJpd7vxNagP8IWvxoQZWo/Qnz+ZTAK0vktGt0aYN98IaoVkfWf0WunZT5c8Y4o/n/J5JydG1qoCcC6ka0loU/N6DBNa2bSDccuAXPwuCoeDQdrdpm9lY3bXaHG/zFpfxx1pqBNKxuW7ChyEFudR8AmCmNEpP6yErNPlpAI/2NPmIdjD8eCs6DTDXRm10FXsp34O
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e159aa6-332a-413f-d602-08de96df9a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 09:00:24.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXqjhOVs4thsz90UFVAPtYAraq0kX9UInIrbfU2b2qwBKKxFZEK+4BaYQN3hF7Pry+3+lOTy/Vya6KYTkfb5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6617
X-Proofpoint-ORIG-GUID: L8UgcLC_Y1JA_6YOevUu6ysQf6LWZ5xq
X-Proofpoint-GUID: L8UgcLC_Y1JA_6YOevUu6ysQf6LWZ5xq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfX0O1q2nkOYVI3
 TiBoPp0OGqlmHtP9fn5g505anrrpYMCO3LMMkeH9k/vbgFfDd2U40NJJ1aZ+UAANZ/Fl2b530d+
 3thAYSpzbALNX77LI0984rQFxEn0Jv5hy19cTQHRkWIBLsTwJugH8ZHfgHGTrAixMemK8hL0r9Z
 fisWoxwSe2ALgG0EjC0INBFYKaYPufh3S0ywrpKIhIRHyoDrck4ReyGAlPAOTmmL1fHMFDVbT9P
 CXdOdaznSdOEW6RF66qizNLPKnM/Atk9/+8cuFh56EZh5GVMduhVMuVEDcCuGn2w7IK0HuZZHhS
 kT6ryx8QCsH/+3fUUVLuFGPaQRfadJV005FfnsZMIF9wQIZsbuwUo8DWi8gwp0V6Zk2FByEPuNy
 WKG5eHSaTZ+VAdMudqeeu4u98ydJKVjZG826JdeKw3OkFlBDYPD3gr8JQVLz7w/zMf0qN2qs2NO
 LUKideV9RlFC+fA6ghA==
X-Authority-Analysis: v=2.4 cv=VugTxe2n c=1 sm=1 tr=0 ts=69d8bc31 cx=c_pps
 a=nsXBGV20ubL322wjlryIHA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=pQehfwC0D4oxWvs5GOjV:22
 a=z6gsHLkEAAAA:8 a=S6-UgkKw-BCApZe8iMEA:9 a=wPNLvfGTeEIA:10
X-Sony-Outbound-GUID: L8UgcLC_Y1JA_6YOevUu6ysQf6LWZ5xq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[sony.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[sony.com:s=p1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3266-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:Friendy.Su@sony.com,m:Daniel.Palmer@sony.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Yuezhang.Mo@sony.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[Yuezhang.Mo@sony.com,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[sony.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,sony.com:dkim,sony.com:email]
X-Rspamd-Queue-Id: 34A273D49C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On 2026/4/10 14:05, Yuezhang Mo wrote:=0A=
> > In certain modes, such as "--tar=3Df --sort=3Dnone", data is written to=
=0A=
> > the image before fingerprint calculation. In this case, ->datasource=0A=
> > will be set to `EROFS_INODE_DATA_SOURCE_NONE`.=0A=
> >=0A=
> > The original `erofs_set_inode_fingerprint()` function only attempts to=
=0A=
> > read data from a local file or disk buffer; it cannot handle the=0A=
> > `EROFS_INODE_DATA_SOURCE_NONE` case, causing fingerprint setting to be=
=0A=
> > skipped.=0A=
> >=0A=
> > This patch adds handling for the `EROFS_INODE_DATA_SOURCE_NONE` case,=
=0A=
> > reading data from the image and calculating the fingerprint.=0A=
> >=0A=
> > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
> > Reviewed-by: Friendy Su <friendy.su@sony.com>=0A=
> > Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>=0A=
> > ---=0A=
> >   lib/inode.c | 20 ++++++++++++++------=0A=
> >   1 file changed, 14 insertions(+), 6 deletions(-)=0A=
> >=0A=
> > diff --git a/lib/inode.c b/lib/inode.c=0A=
> > index 2cfc6c5..51d5266 100644=0A=
> > --- a/lib/inode.c=0A=
> > +++ b/lib/inode.c=0A=
> > @@ -1975,6 +1975,13 @@ static int erofs_set_inode_fingerprint(struct er=
ofs_inode *inode, int fd,=0A=
> >=0A=
> >       if (!ishare_xattr_prefix_id)=0A=
> >               return 0;=0A=
> > +=0A=
> > +     if (inode->datasource =3D=3D EROFS_INODE_DATA_SOURCE_NONE) {=0A=
> > +             ret =3D erofs_iopen(&vf, inode);=0A=
> > +             if (ret)=0A=
> > +                     return ret;=0A=
> > +     }=0A=
> > +=0A=
> >       erofs_sha256_init(&md);=0A=
> >       do {=0A=
> >               u8 buf[32768];=0A=
> > @@ -2018,12 +2025,6 @@ static int erofs_mkfs_begin_nondirectory(const s=
truct erofs_mkfs_btctx *btctx,=0A=
> >                       goto out;=0A=
> >               }=0A=
> >=0A=
> > -             if (S_ISREG(inode->i_mode) && inode->i_size) {=0A=
> > -                     ret =3D erofs_set_inode_fingerprint(inode, ctx.fd=
, ctx.fpos);=0A=
> > -                     if (ret < 0)=0A=
> > -                             return ret;=0A=
> > -             }=0A=
> =0A=
> I vaguely remembered we have to leave it here since=0A=
> otherwise it may impact compressed files.=0A=
> =0A=
> Also EROFS_INODE_DATA_SOURCE_NONE means that mkfs=0A=
> dump will change nothing about that, so I suggest=0A=
> =0A=
> apply erofs_set_inode_fingerprint() to every=0A=
> EROFS_INODE_DATA_SOURCE_NONE user=0A=
> (e.g. in lib/tar.c) instead.=0A=
> =0A=
=0A=
Hi Xiang,=0A=
=0A=
This will bring a bit big code change.=0A=
=0A=
How about changing it like this? It maintains the original=0A=
order and the change is simple.=0A=
=0A=
@@ -1975,6 +1975,13 @@ static int erofs_set_inode_fingerprint(struct erofs_=
inode *inode, int fd,=0A=
=0A=
        if (!ishare_xattr_prefix_id)=0A=
                return 0;=0A=
+=0A=
+       if (inode->datasource =3D=3D EROFS_INODE_DATA_SOURCE_NONE) {=0A=
+               ret =3D erofs_iopen(&vf, inode);=0A=
+               if (ret)=0A=
+                       return ret;=0A=
+       }=0A=
+=0A=
        erofs_sha256_init(&md);=0A=
        do {=0A=
                u8 buf[32768];=0A=
@@ -2014,6 +2021,8 @@ static int erofs_mkfs_begin_nondirectory(const struct=
 erofs_mkfs_btctx *btctx,=0A=
                        if (ctx.fd < 0)=0A=
                                return -errno;=0A=
                        break;=0A=
+               case EROFS_INODE_DATA_SOURCE_NONE:=0A=
+                       break;=0A=
                default:=0A=
                        goto out;=0A=
                }=0A=
@@ -2024,6 +2033,9 @@ static int erofs_mkfs_begin_nondirectory(const struct=
 erofs_mkfs_btctx *btctx,=0A=
                                return ret;=0A=
                }=0A=
=0A=
+               if (inode->datasource =3D=3D EROFS_INODE_DATA_SOURCE_NONE)=
=0A=
+                       goto out;=0A=
+=0A=
                if (inode->sbi->available_compr_algs &&=0A=
                    erofs_file_is_compressible(im, inode)) {=0A=
                        ctx.ictx =3D erofs_prepare_compressed_file(im, inod=
e);=0A=
=0A=
Thanks.=0A=

