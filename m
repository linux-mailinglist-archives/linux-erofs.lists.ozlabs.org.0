Return-Path: <linux-erofs+bounces-711-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 144DAB13441
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Jul 2025 07:40:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br6l161RQz307K;
	Mon, 28 Jul 2025 15:40:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.183.30.70 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753681229;
	cv=pass; b=IEtzj5bRfPYeRfa3wpeM7CgcWVyb5jfYrRHjX07NkbuvKjCnwX2UWJTnysSPdmHH0ItCO9AvBgz81/X7iC0ckjKQnWE8dhHk+SAt4++O1ptfPACANJLNZqVpmMezdBzuKA8lT7RlasNrapJNzTrAIH4dxDxhWAjMnq5x1JcGTTZHrmi7Hi7eNmql/0u3xh6sS65wtOjxjg7WDL7cAxfIFTm1jsvKT0+IPFJb6zvH/T0HaikBDsANyas3DA3VyJ5ZcHUzcDzbNVu20+kiV9Uxq6nDxXU1R/Z30o5clpuAwKwuSLXFYpN16HyDhhjWOruDmKqcCls363/YzOgNXmT/fg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753681229; c=relaxed/relaxed;
	bh=HwnPLwoWmqrDY3cKab4t3A/K3a3YW9BV0PEZyx4DgSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BRc/MbjbbdjovBCUit0BcUcuLRaPBrqduicstLaaH/byuXezbZojBzNt4zh4MsDJpDSBYTVuHM+IyKjWiSEU2UoMLE17FCdz/yPot4locCCJ1kmmJC0UXLedX6YnrFoaMiELlhlS6mA78ske3tl1e/ZT70M7xBzfxYJmn7aSQlYzVD4ixjaRvTdoMV6ArZ7Z2sJ0WRatKmRJZFibNGDfQwYTajdapTZ+z8YedL8Vwcs7ClqjbRrEaeKUChO1Kz6rTI45CxTBAutzQ74Lx+leJNtxh2JHTc3duUccxS8PV3WmGNHE6tXzAz+wW/IWzNFDdR8VtmyV8ePHju88R23nTw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=i9uP5Toi; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=i9uP5Toi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 2048 seconds by postgrey-1.37 at boromir; Mon, 28 Jul 2025 15:40:28 AEST
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br6l00Nrpz2yLB
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Jul 2025 15:40:26 +1000 (AEST)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4k0vs016819;
	Mon, 28 Jul 2025 05:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=HwnPLwo
	WmqrDY3cKab4t3A/K3a3YW9BV0PEZyx4DgSU=; b=i9uP5ToiAZZuI2mik2Mzzus
	c+0XDFH+dm0XUbStzTQ/0CtnV8o6qrGfD+Iv7G3UDjgjSnndh7Sa6xAXboVaHWYO
	uduQICoo8RVlOMgHpkwM6fG6G7Ywx+l9XzL/z2+dVMFaLHHmNy167fekG5C8a3AD
	IHPgMsVbwEnpiwKc6yRLMxWoME/wurKYdSS3HBG4gViigPLDL3t3XiPokChNgTbK
	XmXdlY3THxyBO1dZfYkRp9+7tsvizrNeh25j/1ogBF+nez+Yu5/Q4NwORdbbAnzH
	3/s97YCRRUZgJdMX3B75qKxz2N4/AS3VCqrlyUobWrMm+WX3NSo7Uca86EkqgOg=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012045.outbound.protection.outlook.com [40.107.75.45])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 484mwmh63w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 05:05:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/707vEtGqOXNWFGwzgnlToM3lwQKjDrF78OcFl1nSUQxYd5f8Rs66ZE+WJDgBUYolDNPExrg3FMWop4SP+MoXtcKKBRa1/3b8VJoQvaY90mn+8VQVU4IvJImb+GfO1I8DLzz3nYq4G0tsRbBozIZsmds1gtCSrpN878H880+qsVPZy7wUaXjgn5+iES1Ih9O93MF/DrFmBMnNUsW38AtO23Nbb2WLATCm/7i/drhJug2+JaAywgJehvxXe+PzABEXFv+cx3yCjYCDJxMvf+U5DHe5v1OvChPaII25MJnZuqmIB7Ic48UZb3bwtS6qKdDaR9DIYmUI4BX4bsrb6Cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwnPLwoWmqrDY3cKab4t3A/K3a3YW9BV0PEZyx4DgSU=;
 b=bRs1A/ZW9JpdQGlMr4U/hM9NNp+JD//M0XUyxcO9hNqEsh+BYoQzvIdgA5oOIpPLhw+TotoY/WT8l7aGzDnzR1HqmzsXntdpo8ktwdV/SWNSExUZZFS55jeIluBbL1YkRmFqUjltyz+Y5y3jicjFBtHOV+lArPhkmPIdpN9dLsfhrwvE2XE+W31WenJmqMtiB/DO+DdEVHes+JLWNs/DRXLieR5okV6ztY12EQY0ev0o4ZURiGWX2UjDMPSwv1Ice9w2Wgs2R8p/bPHOanN3Yuhp+RqTrpc1+AahQLV8usbH9VTeImWwdsgQy9WN/iUTdw+QRdh9kQUruSufrf52ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7685.apcprd04.prod.outlook.com (2603:1096:405:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 05:05:35 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 05:05:35 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "xiang@kernel.org"
	<xiang@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "huyue2@coolpad.com"
	<huyue2@coolpad.com>,
        "jefflexu@linux.alibaba.com"
	<jefflexu@linux.alibaba.com>,
        "dhavale@google.com" <dhavale@google.com>
CC: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
        "Jacky.Cao@sony.com"
	<Jacky.Cao@sony.com>,
        "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
Subject: Re: [PATCH v1] erofs: Fallback to normal access if DAX is not
 supported on extra device
Thread-Topic: [PATCH v1] erofs: Fallback to normal access if DAX is not
 supported on extra device
Thread-Index: AQHb/2H5Lu9Ktt+sJUCzGrLqRRK/J7RGzBwAgAAszWE=
Date: Mon, 28 Jul 2025 05:05:35 +0000
Message-ID:
 <PUZPR04MB6316EB57A82516EC6CF0890E815AA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250728014920.1658799-2-Yuezhang.Mo@sony.com>
 <1af1693e-a56e-4835-9744-e0190c28b1ea@linux.alibaba.com>
In-Reply-To: <1af1693e-a56e-4835-9744-e0190c28b1ea@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7685:EE_
x-ms-office365-filtering-correlation-id: 3ea27c9d-31f1-4564-16dd-08ddcd9462df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?arEpm798XP4GWoxYxRsf8Z8fK60OIG0XoVEoRoPMyQtoNdBLJQLc1dimXl?=
 =?iso-8859-1?Q?h1CKnG8+upw35aLDNRl8Qzzbe1IWZDBfZOcTfo7RUfk0CZY3WFMm7PKE0c?=
 =?iso-8859-1?Q?Z13I44A+75srf1wNyBglj/lROHMyyJrdm7Q+6hy7GNyWlMozRgg+Z+aUcn?=
 =?iso-8859-1?Q?ZUU0qkS+2ZqPOogjE/2cWli6WQYvovac7QcKkHMmUZD9sCStU1y18HA2LT?=
 =?iso-8859-1?Q?SjK3r4yL4UYWfIHTBiyg4oJL4ksfzHSFXbmArbiWZT0VUkOBsCN8wvQf0P?=
 =?iso-8859-1?Q?gSM+H4E9SfjjiWHpCy+vq4X5QFcO5fjgxb+V5p7AadbNL5+3/GKaRlptFw?=
 =?iso-8859-1?Q?1vovqXwofJXAMOlf6c2ZHFbyj8t6bOIKoRB0HlEmKqRzNPFBXV5XHBeVs6?=
 =?iso-8859-1?Q?hcykBnVWcDQI7hR62+z+dolrLP2adxIE/Mj1PeaiwPT1uui+3MyYrCBoln?=
 =?iso-8859-1?Q?GgkCtdACJPusXKuasxhJLG5LjMwVqfVdG8D+uRvaC32Pdde6I+79akDtYx?=
 =?iso-8859-1?Q?WbFlIUVocMuswHYqPsd9BMHiOTlwQ7A8LhsovYFKqKvwok2Vb5SHavjOB5?=
 =?iso-8859-1?Q?3Zyg7QXSw2wXyc2gwFUR4+HUWOf+Hg36F033cWuF48OpyCw1S8/2FzyHgr?=
 =?iso-8859-1?Q?V1PhQdIt5pIF5fA8+PU8RpgTpFBpz0m7Gea3A3FBrG2irHeAHSVzEjMNnU?=
 =?iso-8859-1?Q?kpKxSxmt1AZfHrqg2hSikHN9TZWwgQGKkvg1xBs8yS4GwU/5T0XET+ZNpP?=
 =?iso-8859-1?Q?fUjg5ivNj4u2WZFyGbZg+TkOYOmXjQjPeytUm3TNSfuKmk27oCcA+uVaj3?=
 =?iso-8859-1?Q?8Z2LpPJZh048md49RlAXjVFD4ybILgd17AyZu7EaS9TBkWQ5tWvBttH4ei?=
 =?iso-8859-1?Q?Crjgv1q4Mh8I7PtmWn9mMQZABDO68/L0QNRaX7FiVR6d0UOOFNH3l0HJgO?=
 =?iso-8859-1?Q?JQBXcEGvjaj9MDk6cC5+yIAsVqgXFkVXngicEzibU/YBUeqcZYCdipZqwU?=
 =?iso-8859-1?Q?W6yNqAEGPo+7SBJd1O2E9knkSLc3ruWFidwvU21Qmu3V4sw9wzhxU4D+Dk?=
 =?iso-8859-1?Q?HP39L0VvmChqUFSfwKx2rKF60OXhHY9VmTmwmllDod8ki+zMpRTg7VC743?=
 =?iso-8859-1?Q?oziD+Qm3vXCRHh3khEAwctOgRKmEx2r5zdlWMs2P+zf2uMeZcz2btZUoLO?=
 =?iso-8859-1?Q?Ltp4bi5Ia9RwH8eHqbuIgS02n2JMvgSx90czLqKA7ZWfXxAoofkZxezycM?=
 =?iso-8859-1?Q?Ck+GcywyXuR732JktVkkA7WsL60XxwQqtiRza8zvSmRe/2CketmIF187nR?=
 =?iso-8859-1?Q?+g8w5SrbKFaI8WgaU3FgzO1BYjl7IdO6DYqsi9QAxG2gVn9e5M2UIYMj22?=
 =?iso-8859-1?Q?9GVRFcDI+cqM2KqYsGV5TUxunR8vEgJFqVhTogoQiqnVdIY6dXZ5Zr/dVH?=
 =?iso-8859-1?Q?2JgzlyXnVrw8rrSNZj71eYbsvP+6jf2aMAsUScw6x0Bfi7p4ojzpiTeiA2?=
 =?iso-8859-1?Q?lG3kOkc+h+/qLQZUUEVatdzbp1L12VCAoKzl9q4uYPfg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?s1dXRcNvX6zhtu/XkV1/H2WZSnQqQV5xU6VhyaKQ50vQu4beiixgedGFpW?=
 =?iso-8859-1?Q?bvkzqn2UzNubc/ydi5H4j2nGNnnyr3nuWJtYbN9B/lxpX9667/g0AG9KZu?=
 =?iso-8859-1?Q?nZpir4R5t/Sx3E45Nc5eb2hL07igLPrp32SvnBgcGbL75RFbCmW7DX6NvR?=
 =?iso-8859-1?Q?5jwQio8Tq1lzJ3EV2hi9Ya1bArI5a4q77hpRkw156zyiN89NsiANa30LBQ?=
 =?iso-8859-1?Q?yts0DRAGJ7b9NPOHJ/wngISJ5UtAZBo0TlFN1/6xQAEL/Py7JQHKc8haqb?=
 =?iso-8859-1?Q?XhpwDqYWJT0ZMp1Ucm7pnTCfjO7xdNoZYnMIBGu48KWEXXmXPNPxSeT5Ew?=
 =?iso-8859-1?Q?wVv64aunQJioFCBW3ePobI4NTM6idhgzl106XPdo6wbt7g30Lr+0I8kGph?=
 =?iso-8859-1?Q?JmTErx3uC2fhmpTEGwehKj4aoGrMLoHcwgS3KGsQQcBkP66LmjzmGYN3uu?=
 =?iso-8859-1?Q?3XTg8kiMAqvNKtmiaGa1uCdS76raijqKWZ315jvaD95sW6wb6JvM4kdxvW?=
 =?iso-8859-1?Q?g8zOQ6ZRWEjWFi6BJQ6BvJe24gzBW7+++F8DqaSoJrmo9dpSgnflSoNrLX?=
 =?iso-8859-1?Q?Qeh1vToDz6GQb3MM7KI7ztyymulhG0hQ1sKJDYCPPlC5omIEA5LgLuBy+Q?=
 =?iso-8859-1?Q?B46BtsgwrArb948ramrlWACQ769Q/0nBJs+OTMyd1H24Du7bq+rpJnlxd5?=
 =?iso-8859-1?Q?Bvtq+EH4uqjRVg3ixo6fCNV7Sg/ZtRuKa3cKA1x4+5/Sy5DLa5VRrqMuKI?=
 =?iso-8859-1?Q?g4XoCBCNN1EZTesISaRWz/EaEY0h49yTg92BvZ/Bn0tjVkgDMPwNGZQNtX?=
 =?iso-8859-1?Q?zprjN+C8/Ru8JVGfqPa6zFEtu5P/NdywqGe3Df/RO6utQlHRl93Z3q44fp?=
 =?iso-8859-1?Q?ZmRVtZ2/5fnflU0oDKYXb973TFA6AcTmS8CYXTDjxHhQJ07jMBE6lg7iVZ?=
 =?iso-8859-1?Q?teafxpNIIl6YoePBCdgSKmI/X17fYa1xUtyoQbEuteOzqOe5iP17YSZmxZ?=
 =?iso-8859-1?Q?IhEtv/OiQSK6/Hl4HLiR/+goxHBMRCmkeRe9E/EwDIqm95BPmbmLaTD6Pa?=
 =?iso-8859-1?Q?lyIxWnyerRCEQmHA5GpvV3eqBV3fqoBOZP99XnX/6so/WatUiAh9iebrId?=
 =?iso-8859-1?Q?yJXW/fSg/ERD5Mu5cK0r2TkQG/XTI77pYcVDIShg48iR00qU0uOujkG3X6?=
 =?iso-8859-1?Q?oYR1ZA/kh7tYslpTE2vasCeWLr4sOuDS4ExcMaxub+9AF/co6/w8rKWZnk?=
 =?iso-8859-1?Q?0XRZgP84183MLqWWadqU10EKBsk2H1RplU55sADrK6z0U+xSLoLVwSIAUY?=
 =?iso-8859-1?Q?INhvyIg64Pg5DVkbFMPLiPPrXql8QEn54Lrgxaag7H44FiiULNTKglcXaO?=
 =?iso-8859-1?Q?mAo6cp+6WvHD5wTWRaA14ckms7lTgYtvOmufqeRKqvtUdXAoF7fXkXrIyv?=
 =?iso-8859-1?Q?8iwghsK54aN5WP4m65SkKRtBr0QXsVz7MkVTeE3oxsHUTcIJzhi58tiEcm?=
 =?iso-8859-1?Q?aoRRj91OvnjcsspKS/9Zyt6CcYPuMXIELY0EKVBd3ajMwFGZzjwMeOTjzv?=
 =?iso-8859-1?Q?T0ZJtwLNk1BQavjykIPiAaHBn80SCX3Btuul1gsBTnTakU+aXuhS1BaGbS?=
 =?iso-8859-1?Q?GXoD7XxpmJpIPT1qdQqFzpFa8w4Y09StU8jobTL2YUFiGOLYM2vghqR/gH?=
 =?iso-8859-1?Q?ZVU86G/nNM6BdRtL3Ig=3D?=
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
	HGdt3zAI0rBBD1f6fda4QrWaZeQsDUFDf9SkNFEOkMjJThHKAyDdlf+TxfdFr3BLL9Syz+gtOyUm4k8Bt/HFOWoMWxPItgn07brdpC9XqPnviJVKkUOAkC7t/CaCCXREV8CJRxCZEvWPQNAZqAx1mkyPStBd2W7ph68JdsHlslMd+f3g5Ss4Em9KMm7Ro8Qa7KhtYQd6AmTNEm0Y5sDCAhkTg+9P5qwo/6tV9WzlLiy1mRduhqXOHrjDpqGLXlLrO0eFA/jghmrfE56tBsxIDObzT38UGkd2qGqpxA19goaBVsdZaANH+8vtqkBiOVmioQZRF5ErhvzzPcOisxbNaFQR3XpjqdQiBQd5rHxyupCHWuZU878IQsZ0WrI4dNErwQgL6/ebRd8K78fuZZgwOBCK2LP5dPrOS0CjDqfci41BA3f2MUabDf0W7uq3Ly8UMA0I/9MOa6Ba4yLPqUMESgHdOBzpxx/sID9ChVWZ3HmJj1TuQnjqIEFhdlBGeTksgONuKmS9uHyw+W7WpMdwE7i2AdpdKOnc2YrEvm+g9IqbEOC1FNF1OVl0uE/NMYy3V7TTvSjocpqhh+AvMDLvXkdJt9CC6LEDcStggyXqUIvD88QzJEpLbNtbeMh7sVYV
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea27c9d-31f1-4564-16dd-08ddcd9462df
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 05:05:35.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DdKYrJMBazB1mTtPKxnHpkzKzJPtk4M1xiWwgbPxv/UZ0qzBSdXwuAkpOk7w/lUuWmIB7g1fR+/BTaCjXiIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7685
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAzNiBTYWx0ZWRfX+AWlkJCeo3Ln hJkpiGJNUemo2FAPstAcf+7D35PWU0DAYoeJe1N263pDdFfbChht8w5xmYpeuMiJ3WY6f9Jp1jK u9doysrfiEXr6nbPUAWQX3vlK4KckI6FK7DcTRoV/X2cWGGpU3tiHPhE5VZ0WPoTmSAK8H422ZS
 NBkFuii9GRCrzEKNRScHeVGRvGmEt8UJc+05CEmW9ExfVS3CGWpSAWEU8xcQBA2gIbtD7LYkjl7 oNNLGO29M8TnemzQEOg1p+R/SQ37aN9hwSHZgSJMu7CNbASR9UtJcxiq95ZNMlvESSiFTv4eCkX HZjDI3stjQI0ilitxsHBkdi4tgzr4akFl42loeD3yH703Qk6VRBdPOA1TVIPoonc+Nl8mhV/yId
 XrIGLVUM3IAJQeE9DMbgc6igql9sIIgPgLgBtIL+D6MONTls+Lpkd8fT2WPCHBE91NANZBfT
X-Authority-Analysis: v=2.4 cv=Ad+xH2XG c=1 sm=1 tr=0 ts=6887052d cx=c_pps a=F3p6pUzhcF40vTfyvQc7oQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=npRXKgG02b4W-fIhn48A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: M0_an5cPeaxWRq1sP2ZNnm9HUVEaOmbN
X-Proofpoint-ORIG-GUID: M0_an5cPeaxWRq1sP2ZNnm9HUVEaOmbN
X-Sony-Outbound-GUID: M0_an5cPeaxWRq1sP2ZNnm9HUVEaOmbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/7/28 10:15, Gao Xiang wrote:=0A=
> On 2025/7/28 09:49, Yuezhang Mo wrote:=0A=
> > If using multiple devices, we should check if the extra device support=
=0A=
> > DAX instead of checking the primary device when deciding if to use DAX=
=0A=
> > to access a file.=0A=
> >=0A=
> > If an extra device does not support DAX we should fallback to normal=0A=
> > access otherwise the data on that device will be inaccessible.=0A=
> >=0A=
> > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
> > Reviewed-by: Friendy Su <friendy.su@sony.com>=0A=
> > Reviewed-by: Jacky Cao <jacky.cao@sony.com>=0A=
> > Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>=0A=
> > ---=0A=
> >   fs/erofs/super.c | 23 ++++++++++++++---------=0A=
> >   1 file changed, 14 insertions(+), 9 deletions(-)=0A=
> >=0A=
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c=0A=
> > index e1020aa60771..ad1578bb0f7b 100644=0A=
> > --- a/fs/erofs/super.c=0A=
> > +++ b/fs/erofs/super.c=0A=
> > @@ -174,6 +174,11 @@ static int erofs_init_device(struct erofs_buf *buf=
, struct super_block *sb,=0A=
> >               if (!erofs_is_fileio_mode(sbi)) {=0A=
> >                       dif->dax_dev =3D fs_dax_get_by_bdev(file_bdev(fil=
e),=0A=
> >                                       &dif->dax_part_off, NULL, NULL);=
=0A=
> > +                     if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWA=
YS)) {=0A=
> > +                             erofs_info(sb, "DAX unsupported by %s. Tu=
rning off DAX.",=0A=
> > +                                             dif->path);=0A=
> =0A=
> The patch itself looks good to me, yes, I don't think out=0A=
> a reasonable way to enable partial DAX for multiple devices.=0A=
> =0A=
> So it'd better to just disable such case.=0A=
> =0A=
> Just a nitpick, it would be better to align `dif->path` to the=0A=
> following char of `(` in the line above.=0A=
> =0A=
> Also if it's possible, please remove the unnecessary comment=0A=
> ("/* handle multiple devices */") above erofs_scan_devices()=0A=
> together since:=0A=
> =0A=
>   - it was obvious and it might be not inaccurrate;=0A=
>   - it now handles some primary device stuff too.=0A=
=0A=
Thanks for your comments.=0A=
=0A=
I fixed the indentation alignment of `dif->path` and removed the unnecessar=
y comment=0A=
in the v2 patch.=0A=

