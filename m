Return-Path: <linux-erofs+bounces-901-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C36BB338F5
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Aug 2025 10:32:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9PD817qwz3cZN;
	Mon, 25 Aug 2025 18:32:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=185.132.183.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756110728;
	cv=fail; b=EIF7HMzCVGp+wgdElspVhYuA9bzCoDqAiPGWneWqZtlGL4+RKEw7r5it9P7Le21y4XfMLht0EyY7PKGxxMz77exAD3D8kR+IMlf6VYB4JBGCxgcBxy+xwVLf+uMgZ5E5QUvsSoXxN3zRU9c2zpv7UailEReGBxrT18GCFbP/eDLjUiv6P98e8NU1vrspOQ0TCCnHF6pskJZAIg8pPHiPA43eGA09Xsq+ihwEMTGj9lANTo1Mp188GNXePandn/dNNIqkhKOp29oPasCA4qdfa9MVYBM893pq9OFAm/azS/YMnUBsO9k61iFx30CAqhUOwTNxxFQi0/vc/y1a913qSw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756110728; c=relaxed/relaxed;
	bh=7b2bZmci6/44Aij4XPcyOobBz+wOj1DBjY5ZcW92s4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=g7Pc6jz6S+cS53Eek2OcPSioMNd3b0ULgHHKE7MBYMyKaLNvDUesgKXXJn/l8TpOrjpWflxJo7zgBXFnDru9IMpXTp9+m1yF/eGIpBxfdnml9yBY9SJLTuXZzbZlP7YMQUdr8BwyFVUVM3fg5/Ce++OgxSeQ/JBRgWI6BzVfIhJfllgAau6pbpFlDCEFFIcpLSiP9dzauhSGLEMMR/QwFpdrLElD1F6qsJ1164liZp7CSibISzfDG6HGCeTVrTLT8tjX5AvmnOO+/CFtuT8CsEwfHVtF/LmB447XbRB9ys4eQIiypIQYQfJ53fD4uKUvqQ0sVKoiTyHAS+FOk58RmQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=lYYZhePG; dkim-atps=neutral; spf=pass (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=lYYZhePG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9PD66JDqz3cZM
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Aug 2025 18:32:05 +1000 (AEST)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P3YoPr016164;
	Mon, 25 Aug 2025 08:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=7b2bZmc
	i6/44Aij4XPcyOobBz+wOj1DBjY5ZcW92s4I=; b=lYYZhePG3JHsqyJvMzjs8ko
	zblQoOT1Hw5DEiuDNxtXYZe5kLuA/WrwVTn9w7genBeeE5vrXijwy01qgFH+Njgn
	51FEP0GApS8jDYiVrkEDiuc3OYYvRiaIXgbh06HxL5oJQQMpZyeFqGrOW2ZnoxQ4
	6crmJ+li/5g8Vctqi3zWd3gTdxcxoG+jJXZxqg2pFHJvHECiXvE5prR3B5vmAG6h
	ZrkgJYLuH3EACwzFuJcn4yg7aqrbeghVaOKuPwo35gcQ03cqu/nou0mqjAZJn5Nr
	ORKze+TUVcb8DjlLspt/IhVstueaS12LNpN8/+K3qKnGNMXDPfN5Tp0XlccW5Sg=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013063.outbound.protection.outlook.com [40.107.44.63])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48q3ue1jq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 08:31:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWTHv+t5csExKPPeLOdlAdCSLJpltnHLWr7lvTyB+Xy4p04fCNKbD0xXwA2xz+CcI2w7zjkoufIW2NpUObXqod2j8uvhaaiwwcg3ysdxiKwXc4XhyHo1cDNnwCk+qBfklK4PlTZx5fLgHHAtXwrtQqfQEJhSMFVOFyZlqSCdljbXDaGlg9qlNY5aCOP0b6pN0qOyi5LG3fGoW8UZ23sIPc5m7e8fklVGV10jC2e4TBdedK8GuEu/Pq+/jQwokiQZzD+ELvKlBlk9EDS7uajKN0lPf1+wynUtl4UR+f87ik43I1mMccbKZMzxTKELJOZFy3spyH4iAbgCUrwI+9Kfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdqHRzfoPeR60Xv/qFbGd0qbRpLQo9umY13OYw0ouKI=;
 b=ObCEienR9f2b6hE/SKJrM0QV2z+5lHPLLU2rGHdbLXk/uaNMGDlaPlV8ID/wO8EQig5vCtF/6hTXn+3JytoXLN2IhPINj9GKmvlQVnxQ/3aVHEAknCiQOMVfxhoLi3Oe1rkKnSNuAAoEc/CftBXEYzB8N2d8RPadlnk4GW35JdrKfuI6H133ghxOAVDtdtuMgzKrFD0I7QZ38QBZ1DISbJKWS0BIjF1JewII9VzYtq1AKNdbGW6rWx03jmLf48ZJvIDH+tB8j/rbJRKnT/PDOji1xkkSMH5lMfolhYPN2SndRN2Gy8OQzarTobU1gamQ/YKo5LSY61JzM9vx/pHuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by TY0PR04MB7325.apcprd04.prod.outlook.com (2603:1096:405:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 08:31:46 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::ec62:d940:3c6e:2882%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 08:31:45 +0000
From: "Friendy.Su@sony.com" <Friendy.Su@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
Thread-Topic: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
Thread-Index: AQHcE0FlQsf/d+kYlkqYaNKU6IkKzbRy9EiAgAAaeLM=
Date: Mon, 25 Aug 2025 08:31:45 +0000
Message-ID:
 <TY0PR04MB61916FA5AC045C756077C621FD3EA@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
 <20250825065635.2318673-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20250825065635.2318673-1-hsiangkao@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|TY0PR04MB7325:EE_
x-ms-office365-filtering-correlation-id: 09eb0bfd-681f-4589-fd61-08dde3b1d3c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2dCbHVWb3NPcVNzaDNVZ01aRTdFbUg3a2lvVGp5clJMcDJqdkQvclBwYm8y?=
 =?utf-8?B?Qm5veUdqVi9ud0MvTlFTZVBPZ0xhbGlLaUZUZGRJZGdaU1BPdXdleDRXNERQ?=
 =?utf-8?B?NUxNRzh5UVF6SndZVCtrckhwMmRUYzJtcjZxTE9ETlNncFl3ZHhMalVoSmhU?=
 =?utf-8?B?bFJxWHRzYXU2eDQ1VGhQWkpnOFhVM202NTJpWnNpck9Rcm13ekNwR3lKdVcw?=
 =?utf-8?B?eHJhb0NFOXlpZGlpRmEvMzZFd3M1NHM4QmdYQkc2d0VVRGN1VmdmWVRIQzcy?=
 =?utf-8?B?aWZjSFdxT3VqMThacHk0Z0dVcUVlYk9kVkhnbGl2dEMzU0tnalhkYTdwWmxV?=
 =?utf-8?B?OVhueEFqRkRsRklETUJaSDhiSitVbUdPaDBLZGtHY01MUGpBUE5qdnNJNXlz?=
 =?utf-8?B?MFI3elBjY0RMaSsybFIzSFhaY0h5THVlMzRWSnFUSExTZ1l0ZlFOY1QvRGw3?=
 =?utf-8?B?VVdzZVUzeEpYcTA5Qzlub2RsazlleE1kNjVFdmJscHpvOEJRRytnT3dSNFhX?=
 =?utf-8?B?bEluSWpBSUJxRC83RllNcElKbitmL2xXRTBIRjRXT3dzWlpvOU5FSTZjR25L?=
 =?utf-8?B?TmtnTjM3WG8rWmRsaTFhL3MxVnpRemxtVUdFczJnMEZSVWlad0UzQThaWXJk?=
 =?utf-8?B?UjNZOW5hWkJpb2JmZDVOc3RLK0g4R0xoaUl6OU00dXpoRWU3a2ZKdnlhcXdW?=
 =?utf-8?B?N3lwN2lKSThtb3JFNkdRTDlieXRrZytlN3h4VldmRER3MGpYSEZGN2RzMVVt?=
 =?utf-8?B?Zk9aMk90VzBzK01jbHB4VUJmUkZGRFU2dWJ6d2RBUXV3ZFU0ZDBsVFgwYWk4?=
 =?utf-8?B?WC9rK01jNURCcHJ6MndZdFZnNDByK1AzRkp3SDB0T2kxUkpPYVVQWTBLTFJk?=
 =?utf-8?B?VFpQN05sRWZYTW5COXpYNjkyZWhvQVd1NHdIWFR5RjlTQVVRZ2V3WHFVOGZi?=
 =?utf-8?B?d0w0Z1VERW5SbkVkanVoV3BSWGEzVjNLcktGZ1lxYnNscTVpUEdkbFVPMjBJ?=
 =?utf-8?B?MU02dHg2OVRQL0xpbDJzZ2tqTkl5OFlHLzJWN0R0QjdzeWRXeDMzaXZyOU1C?=
 =?utf-8?B?ZUJjTnNsZysrcFM4RUwwOXgzb3Z0RDFySDdoYUQyNU10RWNPNVY3aTdSYlVl?=
 =?utf-8?B?TkdRVk9VTFg0UmswSEo1L3lGdDdneHdlY0R6SzhoaUM0aEYydHc3SmE4VDlU?=
 =?utf-8?B?cHNhQ3ZEWmhob1lkNXVaUXQwRVdheTFBY2RKcnBFU3MwbVpkdy9ZUnBlTjEw?=
 =?utf-8?B?L2g5eUM3WHBiS1RtYS83ZlFPWHpqTG0rY0NkeHhFTVd2Ulg0dHB5TTJaWjJ1?=
 =?utf-8?B?VUZja0lwU3ZtOTlLakw1WGtTcndBNGN6OUFoMnNxbWw2N3hlcktaUXVoclE4?=
 =?utf-8?B?YjgxSFNTNFVDbGFZN2VCNzlFYjgyTEhJSlRxdDA0emVtcFI2YVZxRUlFaE1T?=
 =?utf-8?B?V2R0RFAzOGpXcm9keUg0S1QxV1lqZzlCNTJFMEJBbGtEL25qQXZsZkJPa3Rn?=
 =?utf-8?B?TjVuNVhCMnNkMHhydkpKbnVaSnoxZldkN0QzbWlsOUgxMXJZdjRhclRKRlp6?=
 =?utf-8?B?RWE1c000Sk9WVndZa2lPNnZPNWJHOUEvdjZuQVN3ekJUcDkxVlJqL3NaSGRm?=
 =?utf-8?B?VGwzR3g0Y3FlSjlTSkwwOEE4UVNwV3E1aW9ONnRGeVdNbUgxY20zVmE4TjNi?=
 =?utf-8?B?c2svUG1LWHZZYTgzcS9SMk5pR1QrcmZxMmc0c2haMHBVNThiNXVsNUFPcmpk?=
 =?utf-8?B?RWVXa3g0bkJBbjg4SmJMbldsdUxRYjJsMEoxNERBWVlJWUFKakE1K3duK29x?=
 =?utf-8?B?WGhqemV3VDB2Y256UFFrdzdqWTloRkppUHl2WXlwaEJoUUdaSFhmWmc1U0FI?=
 =?utf-8?B?YUVBaGVtWGRpclJZYTdVWXRmeWMwenRpdk9BZG1Ka1dGUUJUNzA0d29WdWRV?=
 =?utf-8?B?TWJ0NlA0MW9iVWJYNHhxQ3QzQ3F4K0V1UmwzRXUvV0dkeUVvWlRoNTMxdWNh?=
 =?utf-8?Q?OJu7Qs733g3Sc2rd9TKCHDGjmdizSM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SllBNVNIRmFib0xUdFdLQksvdUtHWWgydWxNdnZpNWZUdFVZZXZyN3ZaZFVj?=
 =?utf-8?B?R2RQZEh4c2pMbDVpYjBhd2tKNFIzakZWN2kwZHZJUU1LZ01MbDZnejBSSXBt?=
 =?utf-8?B?RXJDNzUwdXQ0dTBQbEJDNTRhT21oY09TcXplZzEyK08zWDZ0dXRwZUw4S3E4?=
 =?utf-8?B?SFNnVDh1cFQyV2RMMjEzUnVQZjRwNy8xQmxIVW5YN3Y1aXhHMnRtVk1tdlUz?=
 =?utf-8?B?cE1mM3ppRkVmbU9oQ3laVEEwUGx1aForczdZRU9jQjRJZGg3QVkyTnZoSnh2?=
 =?utf-8?B?SjJJaTZkNDlEZWxMaWlBS2w4RExWck95Zmd4Y0ZOQ243NXpycC9UOFJ1UVZt?=
 =?utf-8?B?ak9YanBBVUZMR1pyTGVKTjFvQWRFSnRZY2J3blk2Uy9yMkVzeG9rV3JIMGhE?=
 =?utf-8?B?R1UxMWd0NWRtSDdaOWVKSXMyMjA4Y1hoaW9PT3d2UXRESHVCa1ZwMzdDYSt1?=
 =?utf-8?B?VzhQMzF4ci9UV0RmU3o0ZzViTGI4LzFHRG9OcUlVT1FUVE9YUTlpVXMvSldP?=
 =?utf-8?B?Zk40TUhQaFduUlU3amtmMzhNVUozOEJnbW9oNGtoWlVGS2ZjcnZNQWFWU3I0?=
 =?utf-8?B?SXk3cG1wOHJTWS9ud0RTRWdRelhTd1kvaiswdFZWeTU5VnR4bUpWWWd0SDh0?=
 =?utf-8?B?SWxsOGgrMmIrL21YQW9hNW01U2lSSHJHSWFMMUlKOW9Wd0l2U1RGb0NBaUlS?=
 =?utf-8?B?N1IwWVkrSWpvMlVyeTdla2JyTXJpUEtPNytYVkhONElIclZJL0lMRUhEQlB5?=
 =?utf-8?B?QUZ4RlZpZDlGeE1nSmVxTGtJSFhHTnRBMEpYd3RSeFlHMFo4STkwNnZPNTMw?=
 =?utf-8?B?N1FPNURyck9UcHFxQzV2ZkhtMkFEZjh4ZmdENDZBWStWakJaeXZ6T1g1d1kz?=
 =?utf-8?B?bzd4UURJeUFCQkh3MmVxVDRTQ2lxUnVhS1lnaFErNGgwd2JQUHBHbG9LV1Y2?=
 =?utf-8?B?K016VHN4RzJQOUNMMmkzQm1kU2JMaVJnbzlUZ2pOY0xMaUJWNmtsQjhzT25W?=
 =?utf-8?B?aU8zTktVbXhCYkFMTWJOekZ0dUh1SEROWURBZW5mWWd1eGdMOUZnOGJzZG9o?=
 =?utf-8?B?dkVJanY5UHlicERNRGdDMjErYVVoNjdEYXNlZ2wwRDE1dEE4VTg5cGd2T2Vn?=
 =?utf-8?B?UGFKZTcwUW9ic29WUWpNTFlJbzJacXo4OE9QaXpnaWROVHB2Sitmbk82RWxM?=
 =?utf-8?B?WW14d1laYlc3ODFQdC9WTkNXQmdzaGhUajJUQ3FOeTNFWDJwMmkxeFowclNn?=
 =?utf-8?B?bXdTdStwSVA1VUlLam95ZzZKa2ZsWUgzVC92WkJHTlFzR0RBNFlDd2Y3NVZk?=
 =?utf-8?B?YkdaSGttVFUxKzlNUVB5ZG44VHVtc1AyS3hQUnFHMXB3U2JSSEU1VnhwQTlv?=
 =?utf-8?B?dFZhWmVKam53bmFZOW1rdk81WHhPaXdlS1B0MUlSSjRTRkxBS2tPcm54UFl4?=
 =?utf-8?B?UmJqTXkrZ1lZZzdBeXpBeHc1TzBkQTFHVE10ZHZwWG1jZnR4bFRUN1VJRGdI?=
 =?utf-8?B?QnAzTzZIY2pXTXJHSHRqUmFSV08ra2NqRW9RUkpqeGloZVVteDBia0ZMN21R?=
 =?utf-8?B?S216MllpR2FZdmsvVHZZVW5xa1phQnJhUE5TMVB5SjdRTmhPRGY4eEw3dUlZ?=
 =?utf-8?B?YVBmOUZRK3NDVUdyVndGVXoySjFFaWhqZWtMRmErOXU2Z0E1VERqQXBLSjJ5?=
 =?utf-8?B?dTF3b0l1S2RyZFdNK3daYUpxZm9uU1dOWkZFUEhpWGNyR3NsS3cvYTNVOWhJ?=
 =?utf-8?B?L3puUTRrSTJWTEdud3k2QTYrTnNUcW41aFFic25RN1J2ZHZ1U3FNdmc0UWox?=
 =?utf-8?B?V3NQYUMxMGFYbDNiOEU0WXFpS093SDR1U3YzaDZFZjdMTjFNc29sQzI4bFBI?=
 =?utf-8?B?Kys5WVc0eEpqUnB5cU9LcUtXc0pnanRpci82ZGJIWWlVWE1aYlRENVkzNlRC?=
 =?utf-8?B?bThFUm9lR0E4ZWREdENWZklpbzFoVkVNbnhnaUp5ZDJIZlowVU1aS3R4Q1Av?=
 =?utf-8?B?UklFb0dYQnNablc3TytpQ2RPbHRKeDJzZjF6ZEI3ajMyMnpXMzgwMTJMdlY2?=
 =?utf-8?B?MjVuTUQxSmQzdmh4L294eGdFZHc5N0NrbnczNTZnTW5tdzlzM24xdHBicEJX?=
 =?utf-8?B?VTRpMGZQdGRDYXFneFQ5ZitEajlWYjIrUnJqUk1hZlF4dkYyeU9vcVI4S2JX?=
 =?utf-8?Q?asvmtdZsp2blNIJyaX+p3wQ=3D?=
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
	wdeRgEHOgLaPOqCHLOEDcdZ0YVk74XrBUQif8GfUpVXYZz4yhHpBdthmrvm1mKlA98kY6cgrMghpPS14eXFBNPCg/ytiYPHodHDwSkl0ygngp4ssDgAFA9dzeQX0p8o6WE8zmJvzTjEEFNfNTTRVUyA6zpYb+1liHm6leeX/vASTLAjXTSOEcZ979GpXQ655HzT95peSOqQc8LehxT1HLA4+DsXZeaQYyVs7xKpzHfEd7eQbkCDTbOYio6eqLDM3CG571hUvE9ebVaiD2lPHwo8S5GOwHrjHhqTYpFTZ0i56788h2DSvY4bvypYpPRcWFgIl+hiYl9Dr5p8emiw7so++MplIiE9ESe4B0kV7NJISlZnHbZwt06/AEuDsx1C02qrrGgIGyKJzyohqLzf8UKD2AIM8SFcGj4hEGSTpLnbOBmoD12E5qAqwsTwYqITWTK/qMWwtYEmKRdTQHG0Yeb6uVbhs0hYJLB6mBgJl4i+JKDaTgQ5jZGaYGauE50IjIGn+IcKxiijo0t59bqe8V3FFPgPtSAg7LHGKRCJ22a+K/52o4u1gO5ps8MDHHcE4quzKLfstmNB2MpvzHHzeJU2f+BfLAzwMQdk2vFXOzPFQPfJaEwQq/kaged8+XTpn
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09eb0bfd-681f-4589-fd61-08dde3b1d3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:31:45.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkhR/2mCfoKMP74HUziJfUsQV3JwFUnR1yuU+dyMlfQWgjjtLfhwF+jaXAxbp5LIld5yB3mOXD8/sgbyNM9vVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB7325
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfXyjiJQX5ftYjn nSu/mYzZtij3WKYpuDcSlN2xOwHuhd2+3hA6FDxfj+dBWh70n8NlWUl98VS7hEMaU1y9eIWLb2/ wEYpNf3LYq0TqdZQCNk+uphJ4K0i7zhc6+fUF2nZyAsdtWUhXc2GS4y3uRK5NsQVVpan13GCq9M
 737ndiRyOsxA1FuE1O5Z+3YZiFa54TGn44mSUalO1ceIaFiZFcIHfzgckX0wEuLbVtiXon4BhCI 7wFjMyADWSpRHW20SoMYi7/qR8nc5mmTyaDfvSAJK5ZNnQtOzPENHjZa1UMXYXRCqqQlIfUumQL aEmpLQGKufEqWErBjXEY38qbJOeDMW3oe2kqUO7U4UfLUWb1RTXtVjBOzJzE1Xp3tbJi7y1BAgw yE8MlmTN
X-Proofpoint-GUID: v6Eqm3zX3HeSO1g3_tDa9b8oEMh__UJC
X-Proofpoint-ORIG-GUID: v6Eqm3zX3HeSO1g3_tDa9b8oEMh__UJC
X-Authority-Analysis: v=2.4 cv=G6YcE8k5 c=1 sm=1 tr=0 ts=68ac1f7a cx=c_pps a=iSFZqEFXVSVjeMW94vgYYg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=voM4FWlXAAAA:8 a=z6gsHLkEAAAA:8 a=61dmBc3scJhz3e39i-wA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Sony-Outbound-GUID: v6Eqm3zX3HeSO1g3_tDa9b8oEMh__UJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Spam-Status: No, score=-3.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Gao,=20

It looks nice.

Thank you !

Friendy


________________________________________
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Sent: Monday, August 25, 2025 14:56
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang; Su, Friendy; Mo, Yuezhang; Palmer, Daniel (SGC)
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on =
blobdev

Hi Friendy, I applied the version as below: Thanks, Gao Xiang From 631ebfad=
a7b6733ed31d70692f08a4e0bd3dc0b8 Mon Sep 17 00:=E2=80=8A00:=E2=80=8A00 2001=
 From: Friendy Su <friendy.=E2=80=8Asu@=E2=80=8Asony.=E2=80=8Acom> Date: Sa=
t, 23 Aug 2025 16:=E2=80=8A34:=E2=80=8A53 +0800 Subject: [PATCH v2 applied]


Hi Friendy,

I applied the version as below:

Thanks,
Gao Xiang

From 631ebfada7b6733ed31d70692f08a4e0bd3dc0b8 Mon Sep 17 00:00:00 2001
From: Friendy Su <friendy.su@sony.com>
Date: Sat, 23 Aug 2025 16:34:53 +0800
Subject: [PATCH v2 applied] erofs-utils: mkfs: Implement 'dsunit' alignment=
 on blobdev

Align inode data to huge pages on blobdev, where dsunit * blocksize =3D
2MiB.

When a file is mmap()'ed with dax=3Dalways, aligning to huge pages allows
the kernel to map a 2M huge page per page fault, instead of mapping
a 4KiB normal page for each page fault.

This greatly improves mmap() performance by reducing times of page
fault being triggered.

Note that `chunksize` should not be smaller than `dsunit` so that
data alignment is preserved after deduplication.

Signed-off-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
[ Gao Xiang: refine some informational messages. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c  | 19 +++++++++++++++++++
 man/mkfs.erofs.1 | 13 +++++++++++++
 mkfs/main.c      | 15 +++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index af6ddd7..4ed463f 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -309,6 +309,25 @@ int erofs_blob_write_chunked_file(struct erofs_inode *=
inode, int fd,
        minextblks =3D BLK_ROUND_UP(sbi, inode->i_size);
        interval_start =3D 0;

+       /*
+        * If dsunit <=3D chunksize, deduplication will not cause misalignm=
ent,
+        * so it's uncontroversial to apply the current data alignment poli=
cy.
+        */
+       if (sbi->bmgr->dsunit > 1 &&
+           sbi->bmgr->dsunit <=3D 1u << (chunkbits - sbi->blkszbits)) {
+               off_t off =3D lseek(blobfile, 0, SEEK_CUR);
+
+               off =3D roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
+               if (lseek(blobfile, off, SEEK_SET) !=3D off) {
+                       ret =3D -errno;
+                       erofs_err("failed to lseek blobdev@0x%llx: %s", off,
+                                 erofs_strerror(ret));
+                       goto err;
+               }
+               erofs_dbg("Align /%s on block #%d (0x%llx)",
+                         erofs_fspath(inode->i_srcpath), erofs_blknr(sbi, =
off), off);
+       }
+
        for (pos =3D 0; pos < inode->i_size; pos +=3D len) {
 #ifdef SEEK_DATA
                off_t offset =3D lseek(fd, pos + startoff, SEEK_DATA);
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 63f7a2f..cc5a310 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -168,6 +168,19 @@ the output filesystem, with no leading /.
 .TP
 .BI "\-\-dsunit=3D" #
 Align all data block addresses to multiples of #.
+
+If \fI--dsunit\fR and \fI--chunksize\fR are both set, \fI--dsunit\fR will =
be
+ignored if it is larger than \fI--chunksize\fR.
+
+If \fI--dsunit\fR is larger, it spans multiple chunks, for example:
+\fI-b 4096\fR, \fI--dsunit 512\fR (2MiB), \fI--chunksize 4096\fR
+
+Once a chunk is deduplicated, all subsequent chunks will no longer be
+aligned. For optimal performance, it is recommended to set \fI--dsunit\fR =
to
+the same value as \fI--chunksize\fR:
+
+E.g. \fI-b\fR 4096, \fI--dsunit 512\fR (2MiB), \fI--chunksize $((4096*512)=
)\fR
+
 .TP
 .BI "\-\-exclude-path=3D" path
 Ignore file that matches the exact literal path.
diff --git a/mkfs/main.c b/mkfs/main.c
index e0ba55d..2e6de00 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1298,6 +1298,21 @@ static int mkfs_parse_options_cfg(struct erofs_impor=
ter_params *params,
                return -EINVAL;
        }

+       /*
+        * chunksize must be greater than or equal to dsunit to keep
+        * data alignment working.
+        *
+        * If chunksize is smaller than dsunit (e.g., chunksize=3D4K, dsuni=
t=3D2M),
+        * deduplicating a chunk will cause all subsequent data to become
+        * unaligned. Therefore, let's issue a warning here and still skip
+        * alignment for now.
+        */
+       if (cfg.c_chunkbits && dsunit &&
+           1u << (cfg.c_chunkbits - g_sbi.blkszbits) < dsunit) {
+               erofs_warn("chunksize %u bytes is smaller than dsunit %u bl=
ocks, ignore dsunit !",
+                          1u << cfg.c_chunkbits, dsunit);
+       }
+
        if (pclustersize_packed) {
                if (pclustersize_packed < (1U << mkfs_blkszbits) ||
                    pclustersize_packed % (1U << mkfs_blkszbits)) {
--
2.43.5



