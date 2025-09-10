Return-Path: <linux-erofs+bounces-1011-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2A5B50E04
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 08:26:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cM9gK5BtWz3cl3;
	Wed, 10 Sep 2025 16:26:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.183.30.70 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757485565;
	cv=pass; b=mJww5E5GOJEnk3dH9k5BcQl3d/h+ofQINPFR3KMu6gUTMT6ARvEU3aX7uOIEbbXBALCsbqPTSDCxCRTSDjvSScmSTNWrdenKTbZfmNXGvqw72GhckucQYbigoQH/zcQJR1KgTl1RjhUrRaMBl67/GmYTfC1v4N0jxu2uFpd2NhzTkUlXKbmI+jx4XqhTznN2OlYR3bw6oi+LT9J3tOmT9hIR2S8m7lGhi4hNYv0A+5yQYl6kIqJ9WD9naZUeRaJM5VNKQ+qZ6Sszxhs++xeDYW25Pj63apWz3M8Q5RfE6qid0Y0iVTrnx+50/3frbMnP2UrfZDlK7NcLCiyULDD39Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757485565; c=relaxed/relaxed;
	bh=oqrc3u3nW+iWIsA7ObmKkP2qfibbJpnoMrBoOiDiNgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YTKVa2iDzf2QV4gA2da7GuLmCyQbTjFs99DIjjmjkl1HbVzC+BhEx4xrOVoaSln529hW8WxHucvXYxw+jxOqu3lpRAUUCRlJxOeLtoxBmEG9+udMHLGpnIiStMGAUPTN5yxACWUZIrRgh/61UVBgJu2mQtIGqRmb+HudylyHVnuJV9yQK3B+Sp7ODts+dhpX+b6qQtwYpG/puCIaI42MPartEu1eiCytJaU1WQIqXBEMYx4tXfl26ckDXzVoMqfBj/rNiBFx9AfcyIqaidIRfTzQnDAU0JcriXk8T02TABAe+9j2azol7AcAgRUuQkoC44xH3rMt62tkqzxPkB4ZmQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=kqN/K2qS; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=kqN/K2qS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cM9gH0SGcz3cl0
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 16:26:01 +1000 (AEST)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A5RiCp000690;
	Wed, 10 Sep 2025 06:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=oqrc3u3
	nW+iWIsA7ObmKkP2qfibbJpnoMrBoOiDiNgc=; b=kqN/K2qSe+GuPx/nrOPB7xN
	7FHDLgjMvHqz5ch2rJYJOFjnju4uHQoGVFndKuUlWmftPrYbrYfems8A41+Y3GmG
	M5SFjYWB4sr96/MTDVC6GqzFCokY1nTD1fQoAlzJmDWrp/cGtyLhlHM7R6KdIruT
	GPcJbXT/Lq+3OKN3769Kx2FTeeovYKXIhVF5x6SAj36/x4AkXp2U1nBjXcs9bO3S
	pE3egbObsAwDE3BWCrmtezQpzn1D4IwyPYYVhLkeGmXFcnsDrrQXYk6FCt7z79pV
	Y4hbn66LX+2WGynmG72N2ovGP3vlekf7q6C2DNHeYrN+DVufJzzTuPz/aGi7RiQ=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012049.outbound.protection.outlook.com [40.107.75.49])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 490dbrua26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 06:25:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y05crVVBy7aq0YS5JcMBNIws/RePRzKHCgGw6QzcWHYj42688QkxWR9i7PrF9/AplHFg+QgEJlEYaJXRKQfmMVhiUZOti6Fus+j8beeaahDox5EqSWJRvlWU0c4q9DLXX32m3Av5tEpILAOP3GB1WvqBw1UoOgq4cZ79v0oLTgGwzMAS6aK4eK30ivipsNfLIDRoOdvzsgmjKq236H1vf+MUjTr49dtlmj4lWuEjGP/bWbltCtgVYFMTr+xqB/1cgH6kq9uL6JqIZ32W6qoJ8FqR/LQqBR11IEkJ6GBdwzURLem0NAsIibgbk+0Pn5GAkRw82eiB9Oi9hroufFbIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqrc3u3nW+iWIsA7ObmKkP2qfibbJpnoMrBoOiDiNgc=;
 b=qE+B+G2aBs8OLxsTO5npRd20MwNTJwceXBu5KiHJmZvG9Nii0ViS+ob/bj30GKgfH3PROlzEK/kXy8m6ehIGTpjJ65PsA0UsznkYff0Yb0GjFTA/c9QLcTzY/TVdnm5FE/65tNIebZJMHv5nTV2P9zp0XKc4GXqzXodiaiU/yMvNzRhvmlGiX64zx4WqZireZVxmzliJOyzidXuOAwpiMggog9HR0jAHRCPvSfxQ8Hvva2f0Vt1u7I8RY7vyVXkYasdvPpuC9OTVljX3vbFjs5YAF7EFqjHysfmUEhQ8s/mtuwflQSXsY1mZjaIsURE9k82/KloEmitytB1r0MzYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB7950.apcprd04.prod.outlook.com (2603:1096:101:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 06:25:47 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 06:25:47 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v2] erofs-utils: fix memory leaks and allocation issue
Thread-Topic: [PATCH v2] erofs-utils: fix memory leaks and allocation issue
Thread-Index: AQHcIhC5QiREeD+2CEe0KSvWq1W5BLSL35IAgAAH56aAAAbXAIAAA65d
Date: Wed, 10 Sep 2025 06:25:47 +0000
Message-ID:
 <PUZPR04MB6316D1B41C594C553DDAE72D810EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250910050545.735649-2-Yuezhang.Mo@sony.com>
 <e0835c8b-83f3-41bf-bf67-f163b4cfb229@linux.alibaba.com>
 <PUZPR04MB6316800FA85EBEE85F6EB24F810EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <17dd0ff4-7abd-43f2-94ea-3be0343b3475@linux.alibaba.com>
In-Reply-To: <17dd0ff4-7abd-43f2-94ea-3be0343b3475@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB7950:EE_
x-ms-office365-filtering-correlation-id: 742ff17b-52bb-4965-6bcc-08ddf032e119
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Ma6AlXLp5AO2PASZypYt9flmxYscJq6OGsbHXwXAAtxEn8c14+rio9ZrT2?=
 =?iso-8859-1?Q?1zQKojc3Edm8SwHHPR3Acuoj4jsW/cFxVRgvtx1OLsoh8GE8rlbUiH7M30?=
 =?iso-8859-1?Q?aJyiVnMKrOoUiQP1V99EC8hMgJtdAXzDawJYuIEokhbi3Cb3SBLJYe53hD?=
 =?iso-8859-1?Q?o42ezWSjm145KiBgxGd73PzYOnE4sQNLiiKvlpTi+rDZAuSe9+L5xTF8CU?=
 =?iso-8859-1?Q?PIMe5XowhtE/Da9+T3aQNPnO1epg0RjEa2P+crcMSTSbCYqhMCtaY+3qK9?=
 =?iso-8859-1?Q?JVDsFA+z0QG/d7U9Woq2b2OZw6D+TcQKC8l/z7Um9xN2oNgrpbg2af6tM8?=
 =?iso-8859-1?Q?N6BVkYV9brWLHwIDZMtWliJLo9Pcd5bPKFUkjhEXCdpgzg94a7OKsfvisi?=
 =?iso-8859-1?Q?U3h/FrgnGb6+b8Rr6MZSj4r2dBk+z4UcfRamOwGq+1rCotL2dDk9ENUlN3?=
 =?iso-8859-1?Q?0QQBkPUf+MdJjfg1ph/4z/hQilvCRE1Y9Ri2aM40IvwPNAp6zWcGmqYbFG?=
 =?iso-8859-1?Q?aliL9T/ZSm7RKNUGGaHXML+MYwBCYEwkACqOkC4zC1dY/onzgvbgaUb3au?=
 =?iso-8859-1?Q?jQOEpRCgulyIJo+Ha8DACXj2t3qWJzrT9ZCXvoEhJ9Gfhua4xABkPDohjV?=
 =?iso-8859-1?Q?3FA5g9sKMSQvTBR/UiaZnTkOrqjixqr5bjs2UpV4gW7+O24CZw90J2wZHd?=
 =?iso-8859-1?Q?eihReuu+I/VHC5DliAC6mhFL2MkTfflZTiPfH3teq84UQ27OAXn0bqSkae?=
 =?iso-8859-1?Q?cbsIuGXL78DYuBBoLIhfDnaeajDemBf/Q160X+knR08iBM/caahOaThYjM?=
 =?iso-8859-1?Q?jSuiHskQfc+meRJJOQk1UH4/OeNISVlWOpKN8C3rWw1e8IPSF9n0vgaMfI?=
 =?iso-8859-1?Q?F4gDz+/okQuYft4cebujO7NUnlHROlKZpPMv/Tn8YjOrNSdFYIEgD1HSHW?=
 =?iso-8859-1?Q?vzPR9HTYAMbVjxIKwohIYUlN8uiia3rlk8Ol5iVj4dLwr+5nmEbjuHTHwx?=
 =?iso-8859-1?Q?jTBxFDGMQrCePNKBkUS+UYuY0RDQJ4p+Nr31lNuU4hxduzE8FakFNAO/BT?=
 =?iso-8859-1?Q?K+GpsRgP5lpkt4MCwOQG8P1wiDdFxg77kgFfgX1eU44MYNv2eaoQN2Qc9u?=
 =?iso-8859-1?Q?rDXuqWtTjmg/N4LwI8Bm4tS9t7RyRbIIuI5C9y9dYHse5DjJ38KvujDTA1?=
 =?iso-8859-1?Q?/xQ7zQc2BMZ2WGHF8/YUL0P7vUYQkn1zOzz3TICP7VWA2N9+R7nohByi4G?=
 =?iso-8859-1?Q?TqdlSyxARb0Cu/RZb9fJ9m/unk67wCM7CutT0XjPazzMOijc3a6++MePbB?=
 =?iso-8859-1?Q?ecOgjCQ9JvTOcGsYwVuwoFTrxsvKZIjoXeNcWNdA80Ft4cSI7RKPB/BS+o?=
 =?iso-8859-1?Q?4qX9yrZZ4c+T8/lPzcsie1AivlfrCJ1kkBqQwyS88HeuM250//02RVOpUK?=
 =?iso-8859-1?Q?2w/roZhG5u7jdBni4iKjVODCt521wGSUpd9TUj5ZvQJFOz11ZmU8icGxE1?=
 =?iso-8859-1?Q?Q474V5Bnue8xD/Q6xVHBB9HKt604tNuGB22Li4X+KcbOPTrlHxaoPcvDyQ?=
 =?iso-8859-1?Q?y4wkjlg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fhDaCGbFBX23Ed6zduphvN4fKuoPm6jzDLkCciMvKwcszX2wVCqgER+abE?=
 =?iso-8859-1?Q?9HP6mtxsmmtNtHRrNeczc0f4TqoqGYX0TuVxw3QJLhL2C/NH8fVi3yM9Rs?=
 =?iso-8859-1?Q?Vfiv07XpfNMVdndkkLzczWrzcYrrYaa6/ZEp2Su/sZP5kjsSk2/e/TpWV0?=
 =?iso-8859-1?Q?4Eq6jxUtFkbgI17zgFj8d4fJMEBaVEeVsTLscdL9FW1IOYLDnq65XaQKAl?=
 =?iso-8859-1?Q?o+Td2QRHq7H/4RFD7lTJ3Z4+UOF9kBrp/lRh6E1aFHmD2K7N3s0KKohTKm?=
 =?iso-8859-1?Q?o51o59dfwb9Ir29PnaBaQYhVoRGccVNUh8sAkleN6nzhi6H7eq71NJZSi7?=
 =?iso-8859-1?Q?2TbKTBHdPbXjJaI+f7+RZ9ZlIqfE3NJNrzyGbvrUF4MGp1vu31vN+tY2bn?=
 =?iso-8859-1?Q?OGu5Ns6kPrA7qba2Rly1wydqsqdSHnhMi7SUsfhPtosqt8syNUvGK4IN4o?=
 =?iso-8859-1?Q?SRow3WUJGi+js9RRJbO+v4TcQgdj6nmqeg4g12Sqm93c2I2kFxQFUIPJCs?=
 =?iso-8859-1?Q?tioiCjL6sKCpObwH1XoMl/dhdjieq4ZRbYdxpfJ9BzGXjFVLcygoOEFXed?=
 =?iso-8859-1?Q?L5A7L/faJiqbdooworJ9P67G6DbtgwNbV+Tam6jlAHXS5pZGa2brd5/sQ4?=
 =?iso-8859-1?Q?mjFIfH5tDIST74oi52nkcnXzDAfcgaihSfmFCjh6NmZUJUowSFsEOZ1bNQ?=
 =?iso-8859-1?Q?bohmOM2fTKQ0VtfqYvOzI2RIRWCWk6uONgMQT3OuPNAOhRvXWxqL5/+eAt?=
 =?iso-8859-1?Q?ClVfWIazhEBtyJoNzLv+xQhjamK7ZyB+XkrRBMIHCpS44dqgeiuk1ekr6+?=
 =?iso-8859-1?Q?Cqek+dpkTc3Ruv08XZiQuyXAA4pJjcYojxnNDLyhukMr5oNpjeXgZFuWGH?=
 =?iso-8859-1?Q?BaizXwkrV0n0Lf4/PFgxZdtKag2ltPP+JQvOyUfHum9VfURDuvT6wTaohS?=
 =?iso-8859-1?Q?20X8sSiD3FI9XuMw0Dge8aZ3WdiKosWxX8RyAgiTHQVe0gH/of1ABnZHXN?=
 =?iso-8859-1?Q?ogt1g2EAEc8gW+FtgNbEaYOM69RPmZWhoRIpk1t+MzCL8bn0IA+ArBA3VP?=
 =?iso-8859-1?Q?MxCsnx1SxDGJgroNG02f1tNEA39oHk9MBFPWhGikor1UrzdsYDQzCzXbj8?=
 =?iso-8859-1?Q?bitEtjcMJDM9rpvrLcAwvOtZK99v3p04nlFM/fICEUVaCs9mxO+pxw6lGb?=
 =?iso-8859-1?Q?7E7huW8D0TxalT8wZakliAnvZ9i0Ed5Z5eq2O4sGPxxr+rryRuz0s2+ehT?=
 =?iso-8859-1?Q?ZKOzohMyCF61HMzM6oAEkj0g+Upnf/Cs78dEYu97rMqVi47ro0t1StkAGS?=
 =?iso-8859-1?Q?c28bG1F8VL4qcNpxXFkHKZ8nTdbA+EChNgRb/wwBts1l/0bVzgJ3NcsUum?=
 =?iso-8859-1?Q?s/pWY6+ZgFC1EYvJXWVAzc2f22YBJ2NQIsh8zTdPPMEkWSluxS10M38hvV?=
 =?iso-8859-1?Q?Q4yXxWdcx73/lB4fzHFHqRquGG+KG8iFf78G+1u25PWvnHQc162CC0XevR?=
 =?iso-8859-1?Q?K9AVhsPDxoBrD+mEpOTE7PBL2aU5F2cOAa/x7xwsWyhiFQzomhltoxrRFP?=
 =?iso-8859-1?Q?Ot2kBHVSke3nzEyMfI58g7zvKE4ywjC3ai5V0dJfLJnUlQELdIkdhBt4Ks?=
 =?iso-8859-1?Q?4boYpAEf9BAZ92v84UQkQnNMuqODqoRscbktHiA25rBq0rg0c6sxH1G6+z?=
 =?iso-8859-1?Q?0MUbK+MrIsd9iE1OTNE=3D?=
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
	fQj5TLVQhQan2/ZWCEFijoS/QvwLAmbqSRSIlxpVAdxCojmPi0MpQYYQSW/PW2YNFdpL0cqKC5Qe3JyMoD6VyGiLxHoZB8F0iWtmaC3ecVC2DKvDfT5UdLnkZ2ApJ44B1sziDpsWiUIZ1yFazTyHqAosFZLqikeieDHGEDtVx48Rm+OE3WfhfRTgjkH0tIH844Sa2dkLRdRIxjh3knMjtneA7SInl2PHbvpUiwIFhwLqGNkmX/ImnIBFeMhHcc+GOiG5bbGqj96Ohk67ASk3K/6wwCITExKTJUbCQknHKdyR+SGGEQELdo2njTaUmDStgWWbHP5ws1QCcn/Bel14ValH98HEIlhF8rlNnSec3Y9e88wtRGG7kp4Lui3yXob697xX1CWxIQCUrnt71SItQu605U3Aajl9Yl2Dch4YvtAyuc+YtxdP1p4n5YWzCVzThkeEVl//N5ln0tN995eaPUzLTzCFHX49GFvGSWsqhrTEycI5+gQvjY685oUjizpig+Xb1BnnXysd4d0ryRfDOq9dLpBIwwQJgZKE4PnmV+XokSTyoO/JK4KYY8FcP13T7K1IPYyv3T9Tbi+mYV5YjVJVAtwS/cwigULzWHBor93vhfUK1DFzu4CTIIAgDWVY
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742ff17b-52bb-4965-6bcc-08ddf032e119
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 06:25:47.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOOeRtuq1OrnK8AWuz94EiSAI7XxpaSZgCLpZeTh7gNo/XEARGnoAOieaA8foowVUbvtXUkHfXfdAma1Umktxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7950
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX/hR4y91c9RXS 60CFbnnw9zKuBDjNzrNKSUkrE/VzHr/n41cfCmdcngIoBl+6sOq0pW+58Ft8fMSaSYgspV/m4a8 Hk2+wpoUAGB9pL4zY5Y5NA0UTzX4dEnFD7zz0LJtKIsuSLNDa+rCfrg5gBTM3+NUhMHzPTH82si
 WDOdeYgMxBUcZmFfBrkMMhK7t431hxPXNv2aW5uJlkyDgbVXuVMCwu7ILFseqOFtjGJ4lqRxgJ3 /BBqz77FOtd3rfRa2FbAr9zs+gNHyYDdVuEroolXAO8+4Un6VF/3JP51BZ17RLyQhFx0X7ZEmxm JQ+Ed4U/3Sq4UNk1QJufB3NL4FOg0/pbmjc7KhFVHPi9ByTjaseR6mRJeWQA7Sv38c4dyyRqSVI I+8dfBXy
X-Proofpoint-ORIG-GUID: PlLzSFNjN6nvYmtKW1gAAOLrmY94RIYq
X-Authority-Analysis: v=2.4 cv=J/eq7BnS c=1 sm=1 tr=0 ts=68c119f1 cx=c_pps a=rcmxDtbtz7NqW9+VW1cOGQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=zMHNQ7I2wzxCSumAxjQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: PlLzSFNjN6nvYmtKW1gAAOLrmY94RIYq
X-Sony-Outbound-GUID: PlLzSFNjN6nvYmtKW1gAAOLrmY94RIYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/9/10 14:07 Gao Xiang wrote:=0A=
> On 2025/9/10 14:03, Yuezhang.Mo@sony.com wrote:=0A=
>> On 2025/9/10 13:14 Gao Xiang wrote:=0A=
>>> On 2025/9/10 13:05, Yuezhang Mo wrote:=0A=
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
>>>> 5. Fixed memory leak caused by repeated initialization of the first=0A=
>>>>      blob device's sbi by checking whether sbi has been initialized.=
=0A=
>>>>=0A=
>>>> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
>>>> Reviewed-by: Friendy Su <friendy.su@sony.com>=0A=
>>>> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>=0A=
>>>> ---=0A=
>>>>    lib/compress.c |  2 ++=0A=
>>>>    lib/inode.c    |  3 +++=0A=
>>>>    lib/rebuild.c  | 13 ++++++++-----=0A=
>>>>    mkfs/main.c    |  2 +-=0A=
>>>>    4 files changed, 14 insertions(+), 6 deletions(-)=0A=
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
>>>> index 7ee6b3d..38e2bb2 100644=0A=
>>>> --- a/lib/inode.c=0A=
>>>> +++ b/lib/inode.c=0A=
>>>> @@ -159,6 +159,9 @@ unsigned int erofs_iput(struct erofs_inode *inode)=
=0A=
>>>>        } else {=0A=
>>>>                free(inode->i_link);=0A=
>>>>        }=0A=
>>>> +=0A=
>>>> +     if (inode->datalayout =3D=3D EROFS_INODE_CHUNK_BASED)=0A=
>>>> +             free(inode->chunkindexes);=0A=
>>>>        free(inode);=0A=
>>>>        return 0;=0A=
>>>>    }=0A=
>>>> diff --git a/lib/rebuild.c b/lib/rebuild.c=0A=
>>>> index 0358567..461e18e 100644=0A=
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
>>>> @@ -428,10 +428,13 @@ int erofs_rebuild_load_tree(struct erofs_inode *=
root, struct erofs_sb_info *sbi,=0A=
>>>>                erofs_uuid_unparse_lower(sbi->uuid, uuid_str);=0A=
>>>>                fsid =3D uuid_str;=0A=
>>>>        }=0A=
>>>> -     ret =3D erofs_read_superblock(sbi);=0A=
>>>> -     if (ret) {=0A=
>>>> -             erofs_err("failed to read superblock of %s", fsid);=0A=
>>>> -             return ret;=0A=
>>>> +=0A=
>>>> +     if (!sbi->devs) {=0A=
>>>=0A=
>>> `sbi->devs` may be NULL if ondisk_extradevs =3D=3D 0? (see=0A=
>>> erofs_init_devices()).=0A=
>>>=0A=
>>> I think we could just introduce a new `sbi->sb_valid`=0A=
>>> boolean, and set up this in erofs_read_superblock()=0A=
>>> instead in the short term.=0A=
>>=0A=
>> For rebuild mode, ondisk_extradevs is not 0, `sbi->devs` is always set.=
=0A=
>=0A=
> I think `ondisk_extradevs` may be 0 if `--blobdev` isn't used,=0A=
> but we can still use rebuild mode, e.g.=0A=
>=0A=
>        mkfs.erofs -Enoinline_data 1.erofs foo1=0A=
>        mkfs.erofs -Enoinline_data 2.erofs foo2=0A=
>        mkfs.erofs merge.erofs 1.erofs 2.erofs=0A=
>=0A=
>>=0A=
>> Is there a case where erofs_read_superblock() is called multiple times=
=0A=
>> if not in rebuild mode? Or will there be such a case in the future?=0A=
>=0A=
> Apart from that, I think introducing a sb_valid boolean is cleaner=0A=
> (although both are not perfect...) than reusing `sbi->devs`...=0A=
>=0A=
=0A=
OK, I will introduce and use a new `sbi->sb_valid` boolean.=0A=
=0A=
>Thanks,=0A=
>Gao Xiang=0A=
>=0A=
>>=0A=
>>>=0A=
>>> Thanks,=0A=
>>> Gao Xiang=0A=
>>>=0A=
>>>> +             ret =3D erofs_read_superblock(sbi);=0A=
>>>> +             if (ret) {=0A=
>>>> +                     erofs_err("failed to read superblock of %s", fsi=
d);=0A=
>>>> +                     return ret;=0A=
>>>> +             }=0A=
>>>>        }=0A=
>>>>=0A=
>>>>        inode.nid =3D sbi->root_nid;=0A=
>>>> diff --git a/mkfs/main.c b/mkfs/main.c=0A=
>>>> index 28588db..3dd5815 100644=0A=
>>>> --- a/mkfs/main.c=0A=
>>>> +++ b/mkfs/main.c=0A=
>>>> @@ -1908,7 +1908,7 @@ exit:=0A=
>>>>        erofs_dev_close(&g_sbi);=0A=
>>>>        erofs_cleanup_compress_hints();=0A=
>>>>        erofs_cleanup_exclude_rules();=0A=
>>>> -     if (cfg.c_chunkbits)=0A=
>>>> +     if (cfg.c_chunkbits || source_mode =3D=3D EROFS_MKFS_SOURCE_REBU=
ILD)=0A=
>>>>                erofs_blob_exit();=0A=
>>>>        erofs_xattr_cleanup_name_prefixes();=0A=

