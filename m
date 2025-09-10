Return-Path: <linux-erofs+bounces-1001-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1AB50C59
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 05:40:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cM60b04L2z3ccl;
	Wed, 10 Sep 2025 13:40:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.132.183.11 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757475646;
	cv=pass; b=CsOCH7fLWlZCdkqDo3HVxlZnuWjrREzywcLqoLww4ZUZGI+Kel3xm+XNrtHZl6mcuAnRKtmKJx345zQReKJnR68nqO6Wx1MlHqh73ms/j2DN1f49646fgBNBeCQgHHMIX+8epAusmCk4Aocet9qh2oirnMqo7OwRA24YdpoL0kcIjVAcP5+R3jOlgT7c7CV0NJgUsr6KRIb1JCYwLOU/ERO9z0LB6zQKbYTY8YXm2pw+spYiGjR++WmZfZUQhwIKHo2dgSwu3w+rGW9IBEjhGMKz4Uf6YAsANFHyPgcLeOX4ScQcOCvY0rg5ydYPQxlw7r61NCoQkXO/mn200D+oog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757475646; c=relaxed/relaxed;
	bh=EV1dLrDCbH+bhAXhiGfAgbtHLyg0rwAZWe5tGY8+LuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MII5QvNCGzzjNh05VGIukmvo9tcT7+Y+bHq2K9hh9hlLXwrk9Caxv/UtSfB9BwxHllME2Wwb9Jz8wPfxvYqF6jN3muYf+7yXBbfu62CPQ+5e7uBguPlcW3VRb9rD+xhFWJusfg5idTPq55xlu+o1uSWrGncflpa0ZN/Q/7ZfDGbhfZGFJNCbGsMPQLipTeXDrfFbG/MDQVqUlcLQFqI55zy+GittrAQnZnywo72xA4yKEkGjGUWqRKhVZeL4toHK/uLd/ZzJvPIgiJuhy24H31inRvLFiVtKUxqerK7y0GyONQs+HIIbsCGbb8TegJNZhjAjhIyWDvhNnrJYUO41aA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=o4IaWhYW; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=o4IaWhYW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 2091 seconds by postgrey-1.37 at boromir; Wed, 10 Sep 2025 13:40:45 AEST
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cM60Y2dJkz30Ff
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 13:40:43 +1000 (AEST)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Nvq7J004310;
	Wed, 10 Sep 2025 03:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=EV1dLrD
	CbH+bhAXhiGfAgbtHLyg0rwAZWe5tGY8+LuM=; b=o4IaWhYW3y2gUn78txhCjFH
	CH0SERYR6o6xNXGEYUMf/ita1nJi0qDaye7RKyWP8OnHuBrtNLiO/fZQrTPJamsU
	+8x27yoi7oCeR+ICoNtJUr2DcPGeNLrK43pW31O6WmpuN2ABZAvxXitB49pE2o2t
	yCWw7RJZIatlujdTpewqEqqCu3GdhXjGowP7xr/p6dw0zxQMqG3zMei6McQFJdwi
	XJQFNBZO114yBc121a9IIBmeJ0KojEI5TuoWy3sshObuhb2v8/xvXVrd0EJL0R87
	AwXi9roKmIyUqaTskOWajIA8T1JqslR8UeQqH5AXMjN8hCr78eITJqXd0SH4ivg=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012059.outbound.protection.outlook.com [52.101.126.59])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 490a6xkkfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 03:05:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdVTOaUA4tnm2NpSfbN0fHSRFKkec6MvCk4RTh/P2P3AetqNF8x1e7TJWUYQk/TryYEbxCbCT/ULm/9S15xs6geBLfz/6s8bUoOjoNwQNYLZL/0iMrxSVwFz+L/ASps/JO7CXjGakUXmToXO+VnDSliXKQwXtoGMZDTB1WPPYTCDH7oD7hiwaUfknayYYMM4x3DpAtbnkjxWonS/PyonnN9Vq2zOILI1qSLgk5EX8dYAbH01sCqVqgZ5xd261oDD9S+Cm7s8W3K0VgAAv+LbfN5stcvN3MmIFi/4Pl9B+NKD3TlkJxrvoulHtq0/HQHWdN/VzHY10P7Ah9LghJO2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EV1dLrDCbH+bhAXhiGfAgbtHLyg0rwAZWe5tGY8+LuM=;
 b=Qq0s2qTTFEguDOmHmkp2Q4mcknvwyfK6TtNRRsVhF6AlHYpEhJ4OUNGmqKAIS0GZcZpkdBXOd1EzP9ukl785K+5yrtu2w+u6tDp0M15bHH10+aktqH+3YbB3LDbUUPRM7I5yFVdu1jlR3akkCvCvpWPdxSAB8rzZflxO3CuMLs4Ew7IaVchl22CiTgb1akIkIxBcFeCQg+8wUNuaKAQ5hAIn3XZe6QzPWWFUB99RIltjrH88JHqt2QVH6n8+GdgnB6cq1yUnrHSNKqO4aMs/ZTfpX9CvQK56CbOTUQjUH6TWiAc5XvLBjYLoANEvLmhJ+HXaYXGzd2u/7z6jC3U4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SG2PR04MB5614.apcprd04.prod.outlook.com (2603:1096:4:1c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 03:05:33 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 03:05:33 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v1] erofs-utils: fix memory leaks and allocation issue
Thread-Topic: [PATCH v1] erofs-utils: fix memory leaks and allocation issue
Thread-Index: AQHcITT/5yBPkaIQ9U6wTLK6ybrHb7SKc5YAgAAMIbSAACL9gIABF2HZ
Date: Wed, 10 Sep 2025 03:05:33 +0000
Message-ID:
 <PUZPR04MB6316FFE12E7823C6EA48B344810EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250909025247.572442-2-Yuezhang.Mo@sony.com>
 <0f01805f-434c-4b7a-b6da-52efbbff2b87@linux.alibaba.com>
 <PUZPR04MB6316D33745FEA0695A05078C810FA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <51a52ed7-ed26-46ba-88e1-a45049d613a7@linux.alibaba.com>
In-Reply-To: <51a52ed7-ed26-46ba-88e1-a45049d613a7@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SG2PR04MB5614:EE_
x-ms-office365-filtering-correlation-id: f5730831-8a39-40b4-bbb9-08ddf016e827
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?aWXxQlU9EwHl9gW+HOuC7CEBSifmLq+45QqnpwxiDtpynuCgmT3yY6oCmE?=
 =?iso-8859-1?Q?O4vhbOBNz/Vy1gK7Rq1QqPSHxE0lKX4/6qQ6BW7ojQsc2UIZ4XDKeM/S3L?=
 =?iso-8859-1?Q?WBAe74OsckZaGxkEscFsG/Z2K+4vmRqPAN73tOEp6UVoVPLf49FBdqbJUA?=
 =?iso-8859-1?Q?kTPmLESgD+Qzih8YuSDdJ6OKsbSXREbhi1PtQET4rqKi7LI+7IocveO9iB?=
 =?iso-8859-1?Q?pgd+bbe8zal55p6CsKDJSWbU75vuh20QU5lh8umyvzX8rQAuxTiQakFkyZ?=
 =?iso-8859-1?Q?EwsK5XYttYh0Z564lVs5oCWzld8iUd4vferPi7HSRpYcrweONz9xlpiThH?=
 =?iso-8859-1?Q?ya62F8+pc+vC+VabpYf39yJl0hC6ZsjNrNuIMNQcQy63G6KiJJlgDViRzU?=
 =?iso-8859-1?Q?VpK/PToAUkOeY8xUR2FoB/q+lopbvVmZC+eYGPAL23PupRd8XTayr2NPWV?=
 =?iso-8859-1?Q?zG48/yc7LDzRMxDax5WCwcNbiclxsOtx2HLJrvCTup8E4dqFwmCT2A8rLu?=
 =?iso-8859-1?Q?jDxWPNolQ0a9h6jvL/vrDoYKAO1CNuiMWblzB11Ycg5uSheuMg6OFwqX05?=
 =?iso-8859-1?Q?ExtqmfFLC5TTuukqxp5ko0akTmTfePkaWDzQ1HlYzg1vFWZUuowe2euZLv?=
 =?iso-8859-1?Q?AoYj3+I2xwR5L6BK57kXSn9FfwH2Kvtr/FUAv/zJoUzgWUrroxeVMmVqh6?=
 =?iso-8859-1?Q?6tlNDjtW+WD3jZaoQwZuXPgqjWpsWWG8+FFxe6hYdiCXxTlO54bUphGUY0?=
 =?iso-8859-1?Q?vSizk22Tr89OWmpVQ+lY+xxm1hCQqn059AYgJsrXUDBXLvNplPviZmEhfc?=
 =?iso-8859-1?Q?hUgpNYUYtCT8fpirTVe+JfcurLoNqVwo8xFkjHmv51p3xkTBuA5vpslNJO?=
 =?iso-8859-1?Q?CshzGoZ/PkzJte/a63/GO1gpGPwiOesanEgpMczFxtFFjLL5jyO9fn4BPw?=
 =?iso-8859-1?Q?J3W1qEvh5pBH7BTVwrDVWyexDSxd5+jM2JengUb5Wg7QPTXWB4Qr+rujTs?=
 =?iso-8859-1?Q?lZ6hRZLvt/Mg5D7jiKKgM+iR06SSuVdz+eC+LN2B0G/0SP3qnb0SnH8mVm?=
 =?iso-8859-1?Q?agTeDS7TVJl7WK95a6tAb4na+NL4HV4O1g8sOLPAf+h96TzAFR3n8jcL8e?=
 =?iso-8859-1?Q?U7rqTGF+0ZsNvs1eMctxq3t6ycCKuSvDCwXNSP7iI3pv+IBxZD83R1sK4W?=
 =?iso-8859-1?Q?oUfGBhI2RsHdS1hMu/gmTMpjGAEex8c5LpsluJceAWd7VMNoO1aSXYl1Sv?=
 =?iso-8859-1?Q?c5GLLqkO56UUU4r0o7RcPklvrQerUSe8YG/qnbHBJCYUGm8oSIoEzzAWQw?=
 =?iso-8859-1?Q?DSYik+YFNwTPYUZLM7fSvvkSj0eqyXaHs+zxrM+BpzpmOieKKDl/nM4hy4?=
 =?iso-8859-1?Q?ZDZBgv57R2uLSMSBs96qbtsAVKK4dByqAI2WMcPBg2ezzkj7+lbLRbgsOm?=
 =?iso-8859-1?Q?ELXnIE04v4k4P5bApkOKT2dO+DFadSOUzCA6qJj8BdWTktDpdxWmkpBpLl?=
 =?iso-8859-1?Q?pArEd4yZNnm1+EgrvCpEvjBSaw81hmQcP0loofc/ZgqyN32f7MGX5ujwGp?=
 =?iso-8859-1?Q?6NUn/K4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bGKhTYzLbb598Jo21xwVqvG3ATbVqmQCRGyDwVH3x8qhaG71y7xXTLr/BQ?=
 =?iso-8859-1?Q?EIbbHAVi+RwzkjnVomck0idMzp7uYJws7DeBT9fQxlQnjKt/+24r4JhYRx?=
 =?iso-8859-1?Q?5c3VnrSsmdcWuF/cv4/cxvHV6MU/HX63cn932qCQHcP1Bwb83MY5t+MeX3?=
 =?iso-8859-1?Q?Q5yl8F0eL9rgVzx+9G1wOI4cWsZjn3h7oI1utx6QztYA4GmrZc6N8xZfl6?=
 =?iso-8859-1?Q?FGtABE035lVHgQ5SAAyb/9srhSZNkccG5VHJfd9F998jr4hQMgQDKhgMgW?=
 =?iso-8859-1?Q?4mhsY1wi9Ev/qJFDwVPLxylCI4cbcRnWnPX+0Ymx+s2fW51DBPoPHg8cuK?=
 =?iso-8859-1?Q?5CF3FUYpTaCF4b+oG5P6h3f3JvXnxbSEkLwETd95ua7TycX/nt6rsA+Ga+?=
 =?iso-8859-1?Q?tWbeMiT7S+vLZDkagXrLPvnfNvL0pU2T3Fuy5WG2UFuU4g1kBs3p+4SNYC?=
 =?iso-8859-1?Q?exoXvG6DwuNG69ga98AWeKDTMv5ETeu74jFM2sh79Kp/xU1dGx362vyxg+?=
 =?iso-8859-1?Q?cH4lW1WYyFrIgQOJEyZ1zqpXtGU6fofY4g87ETJxepGPzelBjNgqGbuTsV?=
 =?iso-8859-1?Q?fXCihdUdCoabCO7kEpP13BTtIQGNENpFCJnaA9x5p56gIvW29SehqVOXy0?=
 =?iso-8859-1?Q?UdZJo8U0XiOjg6gb1ci4euKLBReVOUcPzP1zFvCB+f9kbyUqsGupI1yA8f?=
 =?iso-8859-1?Q?xflDfzjtEMmpgkB0FzLxeNO8Iip4Cq6K/ghLl2Yhd+RPRqfeoGI+JdqQwO?=
 =?iso-8859-1?Q?XRGkITMBRfKVUA6VhNjdPn1QOzAfZkU0806rrvym5evuEhpH1wwioDxNXh?=
 =?iso-8859-1?Q?4woj2ffPtTAC1en+VN9ODfabYctdrSpgbTcgNWAJtWxc05cQRrhBSFce9n?=
 =?iso-8859-1?Q?0nj2gapDED5Ti15t7yvT0lSqb61pC8on+RhA4ABOv/kNnk3ZH2kUYctzm8?=
 =?iso-8859-1?Q?cJq77wE8jG8w2g1dPeCpB2QbwnnPfwEdf2NCUGkNMFtNpqTHf9879Btnwz?=
 =?iso-8859-1?Q?URvMvy4LTMKvRQbJCt0wpboZTVczJgKb9NJFuxEqNvHTcI2pZHMCyoFzW/?=
 =?iso-8859-1?Q?vnMaVOKAwwjqb1c7zXHLt4YkoW6BlaIUNIj4UjvvG3u97KSAN1RUqA86pc?=
 =?iso-8859-1?Q?8Rs6UaGEzVErLSWxMkwo/oUuImc4vHv6CU4sKdlBQPAvVagguTDMtE2zvS?=
 =?iso-8859-1?Q?JZpdwS2I+r1mo3fCgBo3PQ/DcIALRRfYR0a8vu2msukC7pGZsKiBd2xEBc?=
 =?iso-8859-1?Q?GkHDx6vxKoEdkwAkq8gWf707jsjTb48psSvuAhbkaPcHnM194KvbstVhMF?=
 =?iso-8859-1?Q?m5kr4bToxvYZRG/Az3E8bldXqgsYMisSIgMWvJJRoHKY0hOuDWTARV/2aD?=
 =?iso-8859-1?Q?TFewDn4FjNFtnAt0UI9eUphBy/2+qa9OQB4Zl/w4d3ZJbIU+Kilc1N9huu?=
 =?iso-8859-1?Q?ZqL/CMAE76kqR0+wg7E1B1Nq8SCqO3yPJeiOLw562LNxzc3kgiurENJSVv?=
 =?iso-8859-1?Q?C9DotqXG3fVhhZThSvck/rVZxrps4uTL2q5GxUjJwTPsQA6OXov2SEUpsQ?=
 =?iso-8859-1?Q?tQ1+ejCJf5HU/S44Tu0YeWnRbeBEHVytTbNrzxF71rxnPgy2Dyko+gF03U?=
 =?iso-8859-1?Q?bqqjKS4jZLDr9jxqv59hNVVVTFOaZdMTSZMgtPEZ62krV76SgjJV1sJr86?=
 =?iso-8859-1?Q?R01zO4iJjb/O2xjjKx4=3D?=
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
	XD7qSTWy4rtCxkE/0T8q+3cCsiDF3iGwnUWI3MHFIpGD8Wtr5ACUFwnkUfV1cOqjCbQO7lJTHHzHQQaEl0Iyy4gtwrE3Xd/t3UOIwWfZvr1bBBnVpXx/naLi37xTtj/yfQZX7axLSQZ85KyWqrzQN7r3JsvuUDO3E7EhInodK2B3JAdyI67J7+a5uqjiZtveHbymBOtzgSCd2E+2VPROmq+JYM9rC1AZqzChIZO7wA44deH2Xso+8+z9PgMKJmg7wewByMkN5w3V+rvU/6xQ6twTW+YmUt1Gt2D8EB1YnefR1GK/a/Cz6Ru818xglNn5Ipb/wH117nvDZMnX9BjsU9GlQ9yXRRFCaD2npg2VTNeY3rZvyfmYINQ1y+34Je9TrMZYGsOVJvwhc4Os8Fym8rAbXRATlJY9PDM3tcU/WhKx77XYVYajTnzjvCosSma8eIffHx+9+yzUet1wxFEUILs+2KZFDcWGW+inl6uptBv9cESiTh5SbXoDvEeon9AbO+3YSwm2z4jhp7HS8kBtgv4etI8N5VlW51FC8rkkJBSW0PhbnfZfDANDVu0C3xqIzoSdoKk695oF/p8f04bgOcSlbo2dhIS39PwAEejrfZZBzJH9eG0gEJq1oamYj3pF
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5730831-8a39-40b4-bbb9-08ddf016e827
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 03:05:33.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eBeOjWIEOSsPEv8Pm3Yfvrb7atyLH1zS1OHEKm1hBqeKevrAouOG2lfW9+tf51Gc4PfSnpJVSfSr58r1MPSdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5614
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDIzOCBTYWx0ZWRfX2j8dGh62BWJZ majQ9WxdDI88ALmeKG5yYSaVgHKYdxKdAPI6idtKiZOzHkoGjPpuoUwdQtmwY8ETDlZxGS+tjGn lVB1c2rz+yBSyDor1uFdcBZU1fd1PKkPRIfp3D+Wxyng/BY+HhS6/Kuin+Rks/t4nwzTrdAEvpt
 7f8ETlimbHiK+pUeNZHIHayiY1uWQhKbV2eHyn1kh0X9TElGCvzbbMhJ1MI+P1hlZ3fHYK29thu 2pOnF8eEmWq3l4I51c+HTJZvWYms+QlSbZkiFnDG9P6Rew4smr2rZP0THVAx9V0Z8CxvkYfOjVL 7YiJ8og8+O+AWTEaOT+hg+WeBktZRE7/QHkqtznSCVf3FyzDp4REC/CnptbO4ROe//A0IpuxCbj kwE0hS55
X-Proofpoint-ORIG-GUID: KokRpK94dgye0xZVdXijxZJpXDT02jLr
X-Proofpoint-GUID: KokRpK94dgye0xZVdXijxZJpXDT02jLr
X-Authority-Analysis: v=2.4 cv=NJ/V+16g c=1 sm=1 tr=0 ts=68c0eb09 cx=c_pps a=dWA8KMk3b8WE1g1edsQVTg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=09ShUQFC06SS25EZz_gA:9 a=wPNLvfGTeEIA:10
X-Sony-Outbound-GUID: KokRpK94dgye0xZVdXijxZJpXDT02jLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/9/9 18:14 Gao Xiang wrote:=0A=
> On 2025/9/9 18:01, Yuezhang.Mo@sony.com wrote:=0A=
>> On 2025/9/9 15:26, Gao Xiang wrote:=0A=
>>> Hi Yuezhang,=0A=
>>>=0A=
>>> On 2025/9/9 10:52, Yuezhang Mo wrote:=0A=
>>>> This patch addresses 4 memory leaks and 1 allocation issue to=0A=
>>>> ensure proper cleanup and allocation:=0A=
>>>>=0A=
>>>> 1. Fixed memory leak by freeing sbi->zmgr in z_erofs_compress_exit().=
=0A=
>>>> 2. Fixed memory leak by freeing inode->chunkindexes in erofs_iput().=
=0A=
>>>> 3. Fixed incorrect allocation of chunk index array in=0A=
>>>>      erofs_rebuild_write_blob_index() to ensure correct array allocati=
on=0A=
>>>>      and avoid out-of-bounds access.=0A=
>>>> 4. Fixed memory leak of struct erofs_blobchunk not being freed by=0A=
>>>>      calling erofs_blob_exit() in rebuild mode.=0A=
>>>> 5. Fix memory leak by calling erofs_put_super().=0A=
>>>>      In main(), erofs_read_superblock() is called only to get the bloc=
k=0A=
>>>>      size. In erofs_mkfs_rebuild_load_trees(), erofs_read_superblock()=
=0A=
>>>>      is called again, causing sbi->devs to be overwritten without bein=
g=0A=
>>>>      released.=0A=
>>>>=0A=
>>>> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
>>>> Reviewed-by: Friendy Su <friendy.su@sony.com>=0A=
>>>> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>=0A=
>>>=0A=
>>> Thanks for your patch and sorry for a bit delay...=0A=
>>>=0A=
>>>> ---=0A=
>>>>    lib/compress.c | 2 ++=0A=
>>>>    lib/inode.c    | 3 +++=0A=
>>>>    lib/rebuild.c  | 2 +-=0A=
>>>>    mkfs/main.c    | 3 ++-=0A=
>>>>    4 files changed, 8 insertions(+), 2 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/lib/compress.c b/lib/compress.c=0A=
>>>> index 622a205..dd537ec 100644=0A=
>>>> --- a/lib/compress.c=0A=
>>>> +++ b/lib/compress.c=0A=
>>>> @@ -2171,5 +2171,7 @@ int z_erofs_compress_exit(struct erofs_sb_info *=
sbi)=0A=
>>>>                }=0A=
>>>>    #endif=0A=
>>>>        }=0A=
>>>> +=0A=
>>>> +     free(sbi->zmgr);=0A=
>>>>        return 0;=0A=
>>>>    }=0A=
>>>> diff --git a/lib/inode.c b/lib/inode.c=0A=
>>>> index 7ee6b3d..0882875 100644=0A=
>>>> --- a/lib/inode.c=0A=
>>>> +++ b/lib/inode.c=0A=
>>>> @@ -159,6 +159,9 @@ unsigned int erofs_iput(struct erofs_inode *inode)=
=0A=
>>>>        } else {=0A=
>>>>                free(inode->i_link);=0A=
>>>>        }=0A=
>>>> +=0A=
>>>> +     if (inode->chunkindexes)=0A=
>>>> +             free(inode->chunkindexes);=0A=
>>>=0A=
>>> For now, this needs a check=0A=
>>>=0A=
>>>          if (inode->datalayout =3D=3D EROFS_INODE_CHUNK_BASED)=0A=
>>>                  free(inode->chunkindexes);=0A=
>>>=0A=
>>> I admit it's not very clean, but otherwise it doesn't work=0A=
>>> since `chunkindexes` is in a union.=0A=
>>>=0A=
>>=0A=
>> Okay, I will change to this check.=0A=
>>=0A=
>>>>        free(inode);=0A=
>>>>        return 0;=0A=
>>>>    }=0A=
>>>> diff --git a/lib/rebuild.c b/lib/rebuild.c=0A=
>>>> index 0358567..18e5204 100644=0A=
>>>> --- a/lib/rebuild.c=0A=
>>>> +++ b/lib/rebuild.c=0A=
>>>> @@ -186,7 +186,7 @@ static int erofs_rebuild_write_blob_index(struct e=
rofs_sb_info *dst_sb,=0A=
>>>>=0A=
>>>>        unit =3D sizeof(struct erofs_inode_chunk_index);=0A=
>>>>        inode->extent_isize =3D count * unit;=0A=
>>>> -     idx =3D malloc(max(sizeof(*idx), sizeof(void *)));=0A=
>>>> +     idx =3D calloc(count, max(sizeof(*idx), sizeof(void *)));=0A=
>>>>        if (!idx)=0A=
>>>>                return -ENOMEM;=0A=
>>>>        inode->chunkindexes =3D idx;=0A=
>>>> diff --git a/mkfs/main.c b/mkfs/main.c=0A=
>>>> index 28588db..bcde787 100644=0A=
>>>> --- a/mkfs/main.c=0A=
>>>> +++ b/mkfs/main.c=0A=
>>>> @@ -1702,6 +1702,7 @@ int main(int argc, char **argv)=0A=
>>>>                        goto exit;=0A=
>>>>                }=0A=
>>>>                mkfs_blkszbits =3D src->blkszbits;=0A=
>>>> +             erofs_put_super(src);=0A=
>>>=0A=
>>> Do you really need to fix this now (considering `mkfs.erofs`=0A=
>>> will exit finally)?=0A=
>>=0A=
>> As you said, mkfs.erofs will exit finally, it won't affect users=0A=
>> without this fix.=0A=
>>=0A=
>> The main purpose of this patch is to fix the memory allocation=0A=
>> issue in erofs_rebuild_write_blob_index(). It will cause a=0A=
>> segmentation fault if there are deduplications(If there are few=0A=
>> files, no segmentation fault occurs, but the files will be=0A=
>> inaccessible.).=0A=
>=0A=
> Yes, so I tend to not fix `erofs_put_super()` in this patch.=0A=
>=0A=
>>=0A=
>>>=0A=
>>> In priciple, I think it should be fixed with a reference and=0A=
>>> something similiar to the kernel fill_super.=0A=
>>>=0A=
>>> I'm not sure if you have more time to improve this anyway,=0A=
>>> but the current usage is not perfect on my side...=0A=
>>=0A=
>> The memory leak is caused by the erofs_sb_info of the first blob=0A=
>> device being initialized twice, how to fix with reference? I do not=0A=
>> get your point.=0A=
>=0A=
> I think we should skip erofs_read_superblock() if sbi is=0A=
> initialized at least.=0A=
=0A=
I will skip erofs_read_superblock() if sbi->devs is not NULL.=0A=
=0A=
>=0A=
> As for reference I meant vfs_get_super() likewise, it calls=0A=
> fill_super() if .s_root is NULL.=0A=

