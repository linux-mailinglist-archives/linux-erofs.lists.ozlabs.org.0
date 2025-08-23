Return-Path: <linux-erofs+bounces-888-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B97C5B327B2
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Aug 2025 10:43:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c89ZZ3tznz3dCy;
	Sat, 23 Aug 2025 18:43:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.132.183.11 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755938630;
	cv=pass; b=VfGDlpulIfAhfvIvg/8ZYp/nH+HKnpl2/D76OUDrImIAwi+v2YaP+X/tF6fIt83g5CEmzZ85fcJw7ONi+sIOTZggUtX2Rpc5MeUTlDZjGLY3+dpL9b7w4OXGTNdF2h1bsXqSI7LInfQ2ASDsP0ycNuHPoTJgbJK8xhbMySM3tpPUVohyafc0xrtPWVK4UBiMaUbhfBpYyqoGCZkRR528gV4SrUAt3LOwl3dUtl+cYuYajTSoJ8zD1LQc6yqRMYPZAygi7Db7FBa0NBkzcArnmcG8/86U7rHJHii30y85d+hu80tBXdC4dL06MflvV0cH0FxISgY0BTW/1CmAHxveUg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755938630; c=relaxed/relaxed;
	bh=Veh4qodmH8/w2CC5g8kL2QcGmwyKAwxUyI9//7R9LsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+FPTzoCzG3v9tHOKJhF1ztWd3kRLBMDjkOBWNm2h3U3r6LKGAnlZy0aB/j2mb1Q9bWBNyX06UzDCN033+8noLL7RQUSi3Qr3wwHRtE++b8oMyp4GyPnpz7WW4wQbi/FY0DATYTi5m54XO8uubWFZPe26jrJPd8SYjAztKnajiZiC7Lfh8dhkOyYtpHPKVy6w9PCq5BjaoyKDJLQZ2IsGoBIMO1ICwOuyWRINJTYlokXh2n8JgzhqgtloHpnqd5UuuHmkP7XASmr/2s7Z39OnCjN7xVz9bB2Iscgw9zKfW9YQRyOewFwjsWwi5hwGA3W25EgvxoHLJHC93pXMlDNuw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=YtfeSVhK; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=YtfeSVhK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c89ZY4gJWz3d8K
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 18:43:48 +1000 (AEST)
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57N8WHL4006713
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 08:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=Veh4qod
	mH8/w2CC5g8kL2QcGmwyKAwxUyI9//7R9LsI=; b=YtfeSVhK6g4+iWDWnX5gaIu
	a33JIl6A8p3X506xrvwF/ktndk0c/sx7c5zcifyR9W2/y6Ewitjs1D5bJq7zMXUB
	WxgYWjE2jXtanQ+C8lfCVvWdGXhPlhlv4usixzS4HeutdE7794K6IeLlCBekZnEL
	Teq//YY2o4iKytAIekM/XarNXNiJN4cYmHBB8qJ6BoMT8MppF1VDKx9ygBtmvTzU
	svpumZFzIWskP7yQfE2RBrcDlVPJos55d6Hteu17dFhxCOjvS43BeKqYvnu0hdBT
	GErvVbQG+y02cLJMkoHMxAuVn4EfzT45oz5qvZm8qhyxeNL2cEfH+GjJnDzKEtA=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013062.outbound.protection.outlook.com [40.107.44.62])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48q6tj03d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 08:43:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoREcSmZr+01RtGeIMo9B2pq+GZco0J0IokW/6kNF1YdOTCjH/Y/v9cuBrETZmSZ02bIvlFmT9uDyjvUgeUvhQRhd8qNmsUi3LGZxiaNWqiAxMzxvRA5zlH07y077EVYzWMjoq33hBxgba9FV+rZsootI3kvZVVlz0uSGnEA/Bf0/AZ4nJuxHfiDh4nxfW9BJplA/iTVDiCWDpZKjOJObJs70mEtciJb+IM8D9Xfr3u5DYcbEvJWSgEutbVdQ29torwToric31B4qZRQA9+QF0+EwDkAuFpGRwxUPEu8HC/FBJdvbPrgECNlA2/jePg3npAN2smOSTeNQb8+R95Nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Veh4qodmH8/w2CC5g8kL2QcGmwyKAwxUyI9//7R9LsI=;
 b=PH0Z6kGGiixEWvxRUR9tEfchyQ9Vwke1sAz6kx79rYlM/O8t9IDS7IKR7x3oibEpFP3uk8xSmsCLJ0jReEfQRtr3343j5ZALsM8ybm/+fnwDLAKx+9dyHgcP9m94I+J93l9SeeYIQPakkslOZbXAi7FFRXn/o5/Nj5LR4VG9s4ogk9FD2IouPFDF2K3+LmJo7vZb+9kqI61wRXLroqxpZ9/BULzHBSIPtapLLss4jvtGfxUafX4rZgGZSenTL8pww+vOwtxcAZiOU0n+CWh9WgZOjA4MBWt++voj3DrKSsslw7qaJxlxfR5sMFDi14dUjF3L5og/OV/wB0hftOaeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by SEZPR04MB7051.apcprd04.prod.outlook.com (2603:1096:101:18a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 08:43:33 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.017; Sat, 23 Aug 2025
 08:43:33 +0000
From: "Friendy.Su@sony.com" <Friendy.Su@sony.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
CC: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: RE: [PATCH v3] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
Thread-Topic: [PATCH v3] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
Thread-Index: AQHcFAkg1ASYLNn9O0+ztY9p9zz9HbRv6lQA
Date: Sat, 23 Aug 2025 08:43:32 +0000
Message-ID:
 <TY0PR04MB61914958B4A5CA1783B45A66FD3CA@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250823083453.249576-1-friendy.su@sony.com>
In-Reply-To: <20250823083453.249576-1-friendy.su@sony.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|SEZPR04MB7051:EE_
x-ms-office365-filtering-correlation-id: 0b51cb1f-32ae-4231-e4b1-08dde2212464
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IY2zbT0uXl0J5xZcwlVpuSRcLmZXCO0y4U/XW4yvKF4gL8jiJ01QbKF7vY7Y?=
 =?us-ascii?Q?jWeOoTLmWeFUN8rP6H9y6fuvbbsIOwKNVJ+TPiQcws2uJnrvJ8rLTE0Si4yP?=
 =?us-ascii?Q?bPaZ7shEk01PrI3+qsLn48dnOkWRIEs7ud47Dvn+ZzztZc9+ueKiPfdlV4vf?=
 =?us-ascii?Q?IER9dcOA78egvrJs82226XdHk/I1ODxDh0d/LjoaNJc37OBkv+vz9f9LVHuo?=
 =?us-ascii?Q?2s52zx1dRmXzcyiMN/7rT0rwkC+4GxVjxsplvjckG2jaqlYgxhgk09FXJw9O?=
 =?us-ascii?Q?PvMEPj/DzwalY178miV9njE9JXKoejxE7ttF6H/3Lamq199MsVyiN1YpfXRy?=
 =?us-ascii?Q?k2OCc7kDPtt8ggEqF2MH7TQnZ3WLmo/F0Duc8hNkSqG0DaiLoBdJNx+otsCB?=
 =?us-ascii?Q?Tj40ma+TaBRpfQgt6EYxcTutHrw/EXplwRtAYYERKMNVmsEhLxMz+6+eG9EQ?=
 =?us-ascii?Q?f7gv1obIPVJ46Nl0axuJWCWgW2vEF3xVwHxxWXWuL1i/D2sQD0J9PktK6Bc6?=
 =?us-ascii?Q?Aqgd50cfo+lec+ae9TnPkrrn62Wv6PhjM8sauNNPXLY+/X6d+F29zmOQrzev?=
 =?us-ascii?Q?arlVLyyUMTJoGSldnn27Xxae8INk5vLAWXacISRa1islAqHaQn03KhAj7tAV?=
 =?us-ascii?Q?rPEqDtwZZwCseaQiwOSHzAjMjW6H2KRiyL04NhkNdlC2Wx1CPdyJ4MG6yV5b?=
 =?us-ascii?Q?0InHJ8GYcqq37ZMayX27/PSTum2xUA3S892xWsM9pr0WaaOMql+hCz15RwnY?=
 =?us-ascii?Q?9S8zZ728mlw2t87Z4bYhv5wRd4WqOC+TMjY462wbsOs7hig8h+vx2FNb8IVI?=
 =?us-ascii?Q?cdoQj2TqpgFG61ONbjfq3UsU8WXnMCfNk6EaEUO29ySXwyC4rTHCHlY9nN39?=
 =?us-ascii?Q?yd9oFudElLKH6Lm66LsC8uHjEaYZrXJVPz1Vl+rAWas+vcL/N13N4wmwQcxe?=
 =?us-ascii?Q?Jne2rY7otkUgXj3E/HNW1j+IQegH4pqs2lJorRtGgB+sZGzR1MeFx4rGVHR0?=
 =?us-ascii?Q?X/L9llbtqNfH93kog4v+1AE7ysMG/tesrNilwfoJo+9jHBtmyik4qXrwrTf/?=
 =?us-ascii?Q?0UT/GolafHvMeawUdh4N5RZIh1XFD0ixlDHfgQrwHQOHLtDiH8dqflEfECrt?=
 =?us-ascii?Q?jb7Uz9MoOzqYa3YsIntH404R7zEdxFb6HON6Ug2CmR1eOLvGPSiBpF5dbKIH?=
 =?us-ascii?Q?jMaV4ottFY85+lskMYFzCJGa9re6tyXlJDnozSXWr3PdAQEJqI9buSbav9uv?=
 =?us-ascii?Q?9PcRPo2XNuUY824qfF4AFP2am/BDIFPQuCagSXpGQRnFv0XgJb/Yn29+8Koc?=
 =?us-ascii?Q?WI8cZI4dKbnlw2nFMWPsyE+oSHAaTn6VLCbVDp8tZBVdOEGWx5r+yuDEgg2y?=
 =?us-ascii?Q?qF9QXJNrrMSzBBE4CcrpYznXxh23c4mPWXq+eQLUP0xbA8T+WqnBb2GhFKAx?=
 =?us-ascii?Q?rgvQwwJkLKwatFC/s5GgBNf6wkMp81bU3HIgppA5EHXiqsPA55l3QbxUzUFb?=
 =?us-ascii?Q?MCt4/1oEN9/PoS8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+mompWxo2UQt5lrTBReuSR9U6U7GGK3qleZWMLFMyHqO0FS1HTe9SXleroQK?=
 =?us-ascii?Q?UqjOimgCV0BDa0gi9b5dVmntf74ALojAqXXFeyDN8/Zr7iFfJpOpB6G7jVNo?=
 =?us-ascii?Q?+Rpv7FoLyqnU+lTdmMIuyD5/t+A3sL7xAKnqxSZYwXzwLrnssD656bkgKRTo?=
 =?us-ascii?Q?FPUYtgxkJaGIdGWGzPYULTii0PiLsG6DOfB/Lza8IztqFqCLGvI7eMgrKcu4?=
 =?us-ascii?Q?1zihTaX9t6CLJTcEkWRAtiPseRU5LwN7SXkES5Qjag2o+wq2ysHNEqepT/FC?=
 =?us-ascii?Q?TNZmAltre0SJkAp0+rOq0MGXyJehDAVelKZNNiS59LNSA+7LbgraESnoVK/y?=
 =?us-ascii?Q?Iw3g15NilkzOo4tRWfTDe2Dbif2xEscdD+XJCc4Ud8joG/NCL9Wwb08AZ23/?=
 =?us-ascii?Q?2bWO2pmIFhnON/1FDXXV27Dv4tyPo32k2hfnRjV1oGBfvq+lMfgUWxxxtcbZ?=
 =?us-ascii?Q?PfKSCzZ3hV6EIT6wfKEE1apb00n4HUO9J+mgnCjJ1gORadjF3FzHZBYcHppt?=
 =?us-ascii?Q?zuamBNrOLESIk2IvC4xvcci66oJatxQ1RqnnMUgmA+4i22122osk/yjpY1Qx?=
 =?us-ascii?Q?bfdxODN3FMKI8mTXwyOi/jVD+49TyXWP/if3l1jPjV3bGTGPtqtM+MeGk8ec?=
 =?us-ascii?Q?6ZjgrUo9ZPzk5EwrJdXDGsMt9iGreg5TjOUp6Nb7ZbWSBNqYyeRAUghEmVLo?=
 =?us-ascii?Q?vve+mD+oTGEGp4WRb1QFoOmzZM2Abp7XxjDbCWBI2Q2/UOA8dblY392LbFtX?=
 =?us-ascii?Q?VDYgCol1tTNigLp39BDX5AbTtJ94XsMP/OksDnqEiQdTpij0I+vo02RxCUhh?=
 =?us-ascii?Q?iMuy3jDKqDuZHxuX3HmHCPXvfpOFPOi9zGTJ8YcQU4lg1cA4KFRMJefKn+vD?=
 =?us-ascii?Q?MflBwQ7q6bw5tHSwk6F9TV4o4aRb0EcCdcFgwDv4Jqcelu/BC+dJ/9pXn+tB?=
 =?us-ascii?Q?EpPgkMdv913bJm2wqr8DX7046qWLnjddzyNWxom4kkKYCUQaGJY2s9O1jOKq?=
 =?us-ascii?Q?0taCdHR05hkvPfc/pgd5mDv6hKk8feMAvs5v1FnItYDhE8QkbbQBxhdaVzXw?=
 =?us-ascii?Q?IpftXoWsVLYnlBVmQULb9G17pfnPO0dBLZloC5A+20gH0FkbH+Nc+ZnS8pj1?=
 =?us-ascii?Q?hb6hPFPMX5vze2wihwFTeddlAsy/SLUYtr/xqxS3F0eqVMQjS/iUiarTruwT?=
 =?us-ascii?Q?Eee0PNTzYMTOPHV2/4riZCi4BlVgZOTxL+GQeVkBtWFnrCcB8UUe7rssM9KG?=
 =?us-ascii?Q?vcJ5C9zo3Opgco56J7fBONcx2KYTPJRQor81h3MqnW72fRO2ZbP+J/4ZgO3i?=
 =?us-ascii?Q?cpo3wuh6IkOrQZGh8v7dPDbnKiZdJiV+xFacBEa8qFrp1+H1m7hH9GkqKvGI?=
 =?us-ascii?Q?spM1rbtZ75MpMbehH5GQQZsqSn8ZtvdzzWRk1QzMzWNHJT+dTn7nbcIa5hVc?=
 =?us-ascii?Q?ugUNyl5m4vy96PViL24pyS5AvkbptL1YnIZAT3t3L7/n2bx7wVmXMGj9cqzx?=
 =?us-ascii?Q?Z/tq4gnqffOeJE2BqUC5cwwL+3jIa72hGbQ1D+dgAIHYD8Z5wmOiUBNf9oWe?=
 =?us-ascii?Q?gyQl71lmCEnldsYcCc/Di7bB/9j2w4FgaqpWS6fG?=
Content-Type: text/plain; charset="us-ascii"
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
	ocCROuQ6OOR9iS+tSvEhLovL00VpGFtFN2w2G3BO1AmZNzJKlpjWhOxOh1eCNlHPrN4/d/3jyCyVIzN2YDzaz7povfQqi+fkBK+81tQ04hU25lLZNUbjTVXZdrlpr3re64OqTlFPEFKjJThQnJSje97qmCDRrErPBoZobLul5vzO0lqQw9CqQk6EBTAfdYpmdI4GhuSAV+U4O9L6aN62XhBymTmJ2kAQPYPbxe18bQOACYGw3/GEbNvmDnXx32TcIu9ZbVmVMMwlvncx7m9qrQUI8svpsiW9y8bf61AKPGarX+HWSizq3gIDYbSMIUeRK4lQAU8/mQo5s2g1h40T55ax6O77nO6JphE9amQksin6er7dAVLkZdqF4dl1O31lfHKDDdb2ljp8u3pN2foBnTWyRban1A5fIJ6O+o1jwRIc6Eb4IggeqDRDm76fdq6SJTwmeGFcWZDWHrYw2vw2DYDBqRIvMWhl4JfCTmysPP+LcD+ltS1+cy2jPyvpmU/5BJ5l4+pnx8KFX9rCleYWsId+wgmveTKgLTGeTTpk147EkkKngkybXyDeD0ocDPK+8tKj0P9OQM1rfVEKippqWVvShUoimk1u2ubGUQ9Ob8IMH9x2g/qn1906DQRf3lio
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b51cb1f-32ae-4231-e4b1-08dde2212464
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 08:43:32.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72UOz8ZQkFXfCsyoYKfWcDCC5Xa+AbbFs22cqB6Tsip8AZhlIobDq7TxqjvoNAQ9DFhH1mdEDCS4RVg5WmJh3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7051
X-Proofpoint-GUID: F745YqN3mFu_U4wP7DijYqOIrEoxE_17
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfX39ATwf1sCvLD /lpy/T5AvFKY2AROvK/1VxwUHoPdUAH/1NSgdv8Xu72xGjgFWd48uXLAk8sRGBGaK91Eg/d1+tn i46GmcStdK8MavgRy1qRbuAZrkFMcBpDClsdIqEIF7KzKAPwFflJH3TePOfTjoVgBGqR9HSNKQ1
 fD8P8IJy33C2aEAVhngfmFn3+x4CS/NZJ75oLKfcLgcUZ7ii+ujpwe4b93M7Nbwe/zRcfW47p6K +Y7ULiBqew6qEhhPHf1t0/SKxCD4YRNYEMELdzmFxUQBtoykyPgFGnUJjP/Vr9mXFMGF7hBL6Sb 77KmJsqcSssUkw8u2hDhK/ygdS3iK9PZ5+deXY1QzFjvQg9wXRjoCQHXCYMeXaPQJSHurhsWuiC c9TrOqeG
X-Authority-Analysis: v=2.4 cv=FaU3xI+6 c=1 sm=1 tr=0 ts=68a97f40 cx=c_pps a=8Ve8JGF/h/GfxA7qsGwewg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=voM4FWlXAAAA:8 a=Y5MG_nd1wxzN9joBLEUA:9 a=CjuIK1q_8ugA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: F745YqN3mFu_U4wP7DijYqOIrEoxE_17
X-Sony-Outbound-GUID: F745YqN3mFu_U4wP7DijYqOIrEoxE_17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_05,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

+	if (sbi->bmgr->dsunit > 1 &&
+	    sbi->bmgr->dsunit <=3D 1u << (chunkbits - sbi->blkszbits)) {

I remained "sbi->bmgr->dsunit > 1" since it is 0 as default.

-----Original Message-----
From: Su, Friendy <Friendy.Su@sony.com>=20
Sent: Saturday, August 23, 2025 4:35 PM
To: linux-erofs@lists.ozlabs.org
Cc: Su, Friendy <Friendy.Su@sony.com>; Mo, Yuezhang <Yuezhang.Mo@sony.com>;=
 Palmer, Daniel (SGC) <Daniel.Palmer@sony.com>
Subject: [PATCH v3] erofs-utils: mkfs: Implement 'dsunit' alignment on blob=
dev

Set proper 'dsunit' to let file body align on huge page on blobdev,

where 'dsunit' * 'blocksize' =3D huge page size (2M).

When do mmap() a file mounted with dax=3Dalways, aligning on huge page
makes kernel map huge page(2M) per page fault exception, compared with
mapping normal page(4K) per page fault.

This greatly improves mmap() performance by reducing times of page
fault being triggered.

Considering deduplication, 'chunksize' should not be smaller than
'dsunit', then after dedupliation, still align on dsunit.

Signed-off-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
---
 lib/blobchunk.c  | 18 ++++++++++++++++++
 man/mkfs.erofs.1 | 15 +++++++++++++++
 mkfs/main.c      | 12 ++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index bbc69cf..69c70e9 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -309,6 +309,24 @@ int erofs_blob_write_chunked_file(struct erofs_inode *=
inode, int fd,
 	minextblks =3D BLK_ROUND_UP(sbi, inode->i_size);
 	interval_start =3D 0;
=20
+	/*
+	 * dsunit <=3D chunksize, deduplication will not cause unalignment,
+	 * we can do align with confidence
+	 */
+	if (sbi->bmgr->dsunit > 1 &&
+	    sbi->bmgr->dsunit <=3D 1u << (chunkbits - sbi->blkszbits)) {
+		off_t off =3D lseek(blobfile, 0, SEEK_CUR);
+
+		off =3D roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
+		if (lseek(blobfile, off, SEEK_SET) !=3D off) {
+			ret =3D -errno;
+			erofs_err("lseek to blobdev 0x%llx error", off);
+			goto err;
+		}
+		erofs_dbg("Align /%s on block #%d (0x%llx)",
+			  erofs_fspath(inode->i_srcpath), erofs_blknr(sbi, off), off);
+	}
+
 	for (pos =3D 0; pos < inode->i_size; pos +=3D len) {
 #ifdef SEEK_DATA
 		off_t offset =3D lseek(fd, pos + startoff, SEEK_DATA);
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 63f7a2f..9075522 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -168,6 +168,21 @@ the output filesystem, with no leading /.
 .TP
 .BI "\-\-dsunit=3D" #
 Align all data block addresses to multiples of #.
+
+If \fBdsunit\fR and \fBchunksize\fR are both set, \fBdsunit\fR will be ign=
ored
+if it is bigger than \fBchunksize\fR.
+
+This is for keeping alignment after deduplication.
+If \fBdsunit\fR is bigger, it contains several chunks,
+
+E.g. \fBblock-size\fR=3D4096, \fBdsunit\fR=3D512 (2M), \fBchunksize\fR=3D4=
096
+
+Once 1 chunk is deduplicated, the chunks thereafter will not be aligned an=
y
+longer. In order to achieve the best performance, recommend to set \fBdsun=
it\fR
+same as \fBchunksize\fR.
+
+E.g. \fBblock-size\fR=3D4096, \fBdsunit\fR=3D512 (2M), \fBchunksize\fR=3D$=
((4096*512))
+
 .TP
 .BI "\-\-exclude-path=3D" path
 Ignore file that matches the exact literal path.
diff --git a/mkfs/main.c b/mkfs/main.c
index 30804d1..5ca098b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1098,6 +1098,18 @@ static int mkfs_parse_options_cfg(int argc, char *ar=
gv[])
 		return -EINVAL;
 	}
=20
+	/*
+	 * once align data on dsunit, in order to keep alignment after deduplicat=
ion
+	 * chunksize should be equal to or bigger than dsunit.
+	 * if chunksize is smaller than dsunit, e.g. chunksize=3D4k, dsunit=3D2M,
+	 * once a chunk is deduplicated, all data thereafter will be unaligned.
+	 * so show warning msg here, then NOT do alignment when write file data.
+	 */
+	if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.blkszbits=
) < dsunit) {
+		erofs_warn("chunksize %u bytes is smaller than dsunit %u blocks, ignore =
dsunit !",
+			   1u << cfg.c_chunkbits, dsunit);
+	}
+
 	if (pclustersize_packed) {
 		if (pclustersize_packed < erofs_blksiz(&g_sbi) ||
 		    pclustersize_packed % erofs_blksiz(&g_sbi)) {
--=20
2.34.1


