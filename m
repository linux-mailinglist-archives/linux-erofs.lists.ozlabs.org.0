Return-Path: <linux-erofs+bounces-3113-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH8AMNI5ymnD6gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3113-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 10:52:34 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6166357879
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 10:52:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fklPW3r90z2xpt;
	Mon, 30 Mar 2026 19:52:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.183.30.70 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774860751;
	cv=pass; b=WKkaVN2z3tRJsdHoEqNAl1Pvb1bZ4g44KqPjL+vhy3S4d1dBheFXDMqklflUzpMzNY0eBI1hcYjjrmN2xIiGJ44/ZpOK4rlPlSLcOljjLCyRvssu9EBtSRZGDmYEyulhK06rFBIrLncIYbRR0cMy5DAJoowoRcNJhm4y3zvNJ6IrdvftFdUoH09uesnTyokimtVCFcM4ocLEba2R8OJxjWT9YLML3t7ZdEYaBtWGHhQJNy4He12oZFR6btnx5Jd3C4DMNcSl56eDytUC1d+kZS3zLeL/szJuf8pgkZ0wPXMAiAE4dqO2tqMecYoGCoa4jbiQ7Iq9N6P15LK9hZcarA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774860751; c=relaxed/relaxed;
	bh=Roj6IQbShJzCbQB7phwrnOn+ZYHSGoOsUrzL2NnCmPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OjGT87j4sy7KxaIcwnlBoCuTwn+QPP0ISn+HInPTHjCKBMnkr7TzpA2fD6yHNOb2oS8IOG5Vo8rFp4Cw7avkaZbxkVwd5B8opY7Kmrjb3nb7CSUghswaWCuOxkTH8U/bF5CcsV/MeX5c8/v2r9d6bi7afAxJl5P4Es1L2uU+MbajJGPRj9g17EnElnGiJjj/Qkw9XTwu3ZJdxdOpALHa1biDd0TRN4l9fIZQKUvfDJugOeEuHEANDL86fvhXa2cvuQ/1C8/jBEiQyxiHOWaCBwTKEg1HywZDOX6pE07bLvSoOYi7MvJ5Sp3VTKBTU6StgmTooy4iUbWrz8wlvZrKxA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=VRCNtceO; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=VRCNtceO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 233 seconds by postgrey-1.37 at boromir; Mon, 30 Mar 2026 19:52:30 AEDT
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fklPV1nDJz2xT6
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 19:52:29 +1100 (AEDT)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U4dPPU2429036;
	Mon, 30 Mar 2026 08:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=Roj6IQb
	ShJzCbQB7phwrnOn+ZYHSGoOsUrzL2NnCmPc=; b=VRCNtceO26baqiBBV3JggO3
	3FxzlgiIXLC4hgVpmwT0dzqmQ8wygdBwX+9h29sp/gBUc2kfFR/ri1qWr8h8DY4B
	Wwgv7vVbhrpjYW7jvge1FIErNFowlvWSdJBvuewvuz5jS0n5xbm7z1+tUJDzn6DL
	WDAqDTqjVQ2egj4wsl35DX0pyARGGmnB0uo+qzxFA8WinQkQgAER8AweA4Anoy81
	mFbhSNN8atD2USEkmrdThhFUD9OG3uJ+/xDw5QgBYnEcfuqLqggEFGnRPajs91OZ
	Hhk1Nz0sE1/SXdacKH1U3g525ruMhNXMjI5MMwa653KlLbP469DjHnbNS1ZfTzg=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013009.outbound.protection.outlook.com [40.107.44.9])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4d65s0sy87-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 08:48:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcaFuo1K8h7ysJM89QcSaDq4AwnDUmgVbVbaR73PAI5LacYSRiShZ11wMMSo+wEB8V6hotG4DQQ1128QO7k8xRgsOGoCin9/9Sngaw7XxzdMNZtIYfA95oLBSIiGsUCjDpfdp8V3Rs68hIZetGaKxdGiMA6i8crVVoLtqhq972O7guJvrbx1PSAHeHT1UuZ9T7GZ+iCADZwJz45lNDyP0OQKZNfxDYnGX8b7SCemHRgsp/w/kIkZJDw2dWIvWtKUBLffSj7F8dyaJzADzuUhhc2fL75pta0AYncYDT7TmMYYWCNH/88jjYSK7cw6898qrkdFAAyK3pMv/rB44H1Z2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Roj6IQbShJzCbQB7phwrnOn+ZYHSGoOsUrzL2NnCmPc=;
 b=af/BbQVFqhL1FZX8GMCA4FaHZoHY2qw5qJZXT/Pz31UAFymbCBiGq0zp/r/8KdpfB+EOwFI1qFe2lhSPUVG60CcOunGlkUcAbhhHwjVcP+jFktMl+IIQCUhwCKmsS78SVGJ0xq1CbHJYKXyoaA7Df0ZxhbayWcy/sRLovDQy5d+XFoDFDEw6Va0LhQRtkTFAEVxHU1kOUEFd228P9zFhfblJYdH5DHosbV2IZTFEV5Pwex9lieW64qqOI4eMPfSid4cfoTyQnKK6vv7XZVVT7OrjHOkJYA5zl+FfzD72WAXmUCbUL1/haf2vHUuPuh3XrDDY4Lbokxv5Arfc99Wdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by SI2PR04MB5774.apcprd04.prod.outlook.com (2603:1096:4:1e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 08:48:09 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::bc92:94bf:cf9f:313e]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::bc92:94bf:cf9f:313e%5]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 08:48:08 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH v1] erofs: remove the guard of showing domain_id and fsid
Thread-Topic: [PATCH v1] erofs: remove the guard of showing domain_id and fsid
Thread-Index: AQHcwBf2tFxXmbo/Zk6ztqf4PQ/98rXGsq0AgAAP/Lc=
Date: Mon, 30 Mar 2026 08:48:08 +0000
Message-ID:
 <TY0PR04MB63282B4D6BAEF754115502548152A@TY0PR04MB6328.apcprd04.prod.outlook.com>
References: <20260330073235.3328579-2-Yuezhang.Mo@sony.com>
 <bc6ac6ae-ef88-4ff9-96ff-3395f84ce4ef@linux.alibaba.com>
In-Reply-To: <bc6ac6ae-ef88-4ff9-96ff-3395f84ce4ef@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|SI2PR04MB5774:EE_
x-ms-office365-filtering-correlation-id: 7830e53c-5809-450c-3689-08de8e391148
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 F5k/51jN9ZloMU38SbntzLOX4ndlAY71nCQ8xcNe5EYpleW7zqff0YiixygbEC0VRmjKUd+gPHhISZKgL4MCeyRQBWzvfBjKX9EH92We0AxciE7XEMhtyrQg96X+gjP0ObHgw0qRtrK4tvdvAb9FqNe5Xp/TGLLTnDYGWXXjzV62eOIGCtgAx4JbMI+5peZxcFgDZk6Zq728s4v8WdQjL93qL2LxeJrSK6gq/nR5G1SC5oBNrcD0zrd3R1JcOiAfwu0GTCcS03Bp9LV+j+EBvmAP9arjikAeiMwiq28ghyNTZhVsqD7Kv347PAUZevFE1d1L9IC5OEtcyT0KX35SdCtgaVoRiDKSd+4htBfn59bcFfVGgGSkCEtT2L0pY6MAhy1P9ituNZ8z0vttDduV4zmbrC1bvXkSbvftLB2ZO1RjYUUFZpQhPQKqya3G0tj8ZxNg0tmw30OF25dxrLcgld2tna/fRm2ikI3cCHICzBk5IChHpb26f+MCPv4Nj1M+bgp4GQLHRnKcvKxHfTznZ2HT+9K/bbNFemEHwW5cGH8Qlo6mzOAyuOdfnK4NRuuZqINwmenDqmzf3lP8m0y5tylOWLjqDYJ3W2nF2osRNnP7TSJnasRkcrdESTCDw1ikRIA7MY2fPTKD/rye2RK3b+ZrWwzXZ6wChqjs0W1PxepDEQnzxjvFCgGGLd+0xQNQX7Fe8C11gcGbGYYD6dGavKNwXw+D6oGcMbnwGUikLmYpkw6Rr97e5G35mvf2KMaIol2VgOQKBIecz9T8HKc8ODz1sSyeLd+YesR9hl34e1M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uuMfKMjl1LvuBHMxOuaf0lol46afdtQ1qXpOFSCjn+uKic44Puwk2RG3Tz?=
 =?iso-8859-1?Q?rwZn5j9JAsKhfIylZpC4NsyfvaMY5J4q8QZzkzAGuMS1k7UsVJLpPgbkBD?=
 =?iso-8859-1?Q?UE/YOw84DC2uSXLZOUF7Z/Zgq/MUwyAZ7D4C8t8TxgIVlhyMWg1oW8jfxZ?=
 =?iso-8859-1?Q?a/YKBh98maJxXHK6y8wEATXTjUl5hTua5VSIstsm2uM7o4dsMEWuo2aH9V?=
 =?iso-8859-1?Q?hHdyL82GYXKj8ZcDRiHRTCbG0jKxGz1PBopjsFdtXfOneCndl7IMfQsThp?=
 =?iso-8859-1?Q?gpxgfyho0j3r0H8fLFc1Tp+kfDa7ItSR/Sn6qKDsnVeykjMOHoK7qgi9cN?=
 =?iso-8859-1?Q?tbWLik0lU5MHHT3ENHCKgbb5RqBgDbyCP+mPOl3Kd8NtZlsshQvBwxOnf5?=
 =?iso-8859-1?Q?QRCZHJzvUC6zIjCmnXeAjanzkafVQ7rHvesIh0sseRNJ5/hAlf7ELNKDks?=
 =?iso-8859-1?Q?iUPD8x5RONERkA48JZCrvYu5ruALoS/MaWZufdB3qMXEhw3DaxnPBqsin4?=
 =?iso-8859-1?Q?X2NvRUWUUDB0kWW+Jl2xSIjedFfY6kfTVlVWj2GNIS7Znn+CdTGR7VQSpF?=
 =?iso-8859-1?Q?HqITtr8u/n8EPPJBBPMx9dxXGSNVS+Lmqo620A42lSonCdra+tjrXEQQ8s?=
 =?iso-8859-1?Q?nKOJVYwxH5MNIP0gZqHika5XI0zhbM7lYUsB+8dB8gJNMWZ60HR74/zyuN?=
 =?iso-8859-1?Q?noK05erl4Fv8KMEmMac4wJinvsIthNbJhhU7jJosXIVddzqAdijNtU7Gcr?=
 =?iso-8859-1?Q?Yk1m9inbZBx0b0KPrSn39vHgl/OCzl34XCPEfOt/UWTZrOJDMBFT2fj9pj?=
 =?iso-8859-1?Q?9Sy1Jg8iJDOs7Lkhrlj/NsKl9qFxzh7SmUypWbWIz4YnYGfE5jF87DpGYk?=
 =?iso-8859-1?Q?qwcWMvq7fqy9KuZhhtxqu5CQ6OZ9uPBJKiZnJXT1x6exZ+Qf3NXb9JdxqK?=
 =?iso-8859-1?Q?MYX2frm+rLFkOTKpNXEkofisSr6543F8lfD7JMFuZ24kG6SC0i1dOBD6Rg?=
 =?iso-8859-1?Q?vqfS8y01jZOp+DohvMpFBMrwhISw9aWG6IAz5Loo9f/o28pzkKsNXSifE0?=
 =?iso-8859-1?Q?jTh+249hV6P9sFDVXcFk6db/rjSh84FI9abvQG2/LETLDvJifT+V6m3lhb?=
 =?iso-8859-1?Q?4nYxndk/2Sc33T/nIkQxh0f+UlBsSTUsHuvjSu3Wdqpg0qk5jRBLaOKF9G?=
 =?iso-8859-1?Q?FfcTAEX09BZhEtMqSS+BptCAcmI0ZIXkTJyMV8YJbawVDUnZvLWHoLIlgi?=
 =?iso-8859-1?Q?CLTPNTZgR+FP1rhRQSLYMc5t3rOua61qVAf+wCbeWyuAYeYjpkjunTwFrC?=
 =?iso-8859-1?Q?GcJcu6yTdwnpQUs25dQxjgXnIxRRhLNjKwryIOvsJzvXai0LIn+7mRr9hZ?=
 =?iso-8859-1?Q?3YKuFqtry+mPlysed3nQgggglFB6nfqpfN6kp74D20hqPuzJQjQs5fnEuT?=
 =?iso-8859-1?Q?QFEmRYKYGiiO+pvtI1C2z8P7PkrgtKbS7TkhT/RmLmHgm4AB2KW7u2TtGF?=
 =?iso-8859-1?Q?Au1bHh8Hjsk9xxSZmMeFam5Ou6Gp4s3121eGoVXsUTDj4GwzvQTsva86DZ?=
 =?iso-8859-1?Q?8j7LRoV5iZyi93/KMAnphqPDP1rR4k64qV5i+8cgrVP4yvrfFaMDUgigxV?=
 =?iso-8859-1?Q?jSzWnq5E04dITzY/3XH57HEnuSAyI3ewV1KJtlPcWOK+yqCDhile+5dKnn?=
 =?iso-8859-1?Q?vio7lw22pbaECVlbzkfPLlx9M3Y202ivn23puxw14ucL+eqrwlLmDwIwj9?=
 =?iso-8859-1?Q?F4BFjzmy3Crkro73mkczpAbyjusnFIDkUXytV68uW/lRO951tyJNXnASw0?=
 =?iso-8859-1?Q?UgFQyNcYcw=3D=3D?=
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
	AyzskZkhaTF3g1hK5SA02C+SMu5GWHk7iXMK2wSUjKM7wF9YQ1VUemXLHKtplR1wL527jeVlfm+nVteX6xChYBL23mu5ZzJedB6eUaJNTuZs7qMFg+vMwidUGwVM+xMPDDeN+W42SMuPS8p9gJlvFLWn8fgUlmx4Vd+AP65T1Z/UqIS2GLhzl/3cVUxm/Y5FpWr5HQWcEd+8emQkB3p5zgryFneiBKyyFDd3ui5RQXCpgyX7mOQs9ZTy+PMuGY4LaO/TkjhW2ddDisiVUlfKwON+7gdd4SK0zv1fEQdTcZF2P8hIjmDX+wwnyPnMt00lbWDoX/f/ALFeN6mz/4mf8Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0o6mqQvP9IqDS/EsSNIKPorc8uT0xgGIHcew/77uQ0e4fWAy/WaUKy5rG4NOD0gDvDe5ao0cV4MHEyRx7iBdnNe/Sb14MHZe7BFBdbK3K1QYQRWX23Tz5Xe3qqug00JMVYtKbsUDspvNVMXkSMh/xpOjdHDn5mNNNXyMUF7hIRk4hKtiqnS+JON9UNmxfCpsi1Rcidbxom3lSKThKIGsy7sn7dbvRafHWhrLP7+bZLt/fwjJQv/PC/NmIfQLt6be7FmdlmmPlpctYjcsifd7nOB70RYFzLLHjTDlHXVFkxPgJX7KD+M2d5hVbotG6LL1q42yusb+kXaWZONMTm0Bk8NTo69PiLGAIQlYroqCXKpbvDGyZZeHkfcClTsfzMolxRqcPI+Qk5XlnYXitarVh1twIvJXqQ2KXxxIKcBA7XU52PT2tMSqqBk/fiO3Ao4lADSsUMStu+VZDuBRNKBBxeBHkgjNEl/abAsgGN5R+OLZdEAGiApnYei1CGtrkPRLHKe8bWAotpeGqnGXGpBdd2cUq/EnSSvpHUhpM6crw5YDf7HVSqE2zaQDvA0Sic+AjJhgV7Wnw1LQBTZaZrUT+WcN6VOhiKi0sTuiVEPFrFrQtHRmhaS5fguKtAChgyPk
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7830e53c-5809-450c-3689-08de8e391148
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 08:48:08.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7JhCAKWSyIf3QeX71Dlae1BLXixLdyl6BUhvXXpb2rGr7y/OgzcKP+jDgF3DzrDDULIj2QtjRgmtXA+NYy13mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5774
X-Authority-Analysis: v=2.4 cv=NvPcssdJ c=1 sm=1 tr=0 ts=69ca38cf cx=c_pps
 a=O5m2r3WRhum99gqPKpwb5A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=cIyGuqrkuvkXWOl_fzuj:22
 a=z6gsHLkEAAAA:8 a=fvPdx_XSbdI_cSiGY3IA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2OCBTYWx0ZWRfXyCEP5us+z8JG
 GrlhBwTwAb37yQ38HFv4kNowCoOCOyfunKnIvTeKZYj+3qyjg1QMcO6voxFX/g+er44eqHcAuWU
 q7pucm9/jjWdqZ3AD4iHb0q0rwjmN797VrJpNB5RFM9kZJ4uVplaIq6xpMLbS5RYnOO3DaGtCeh
 n4OJn31g1kfTWEsIxNBaJEoyO77iP55fl7uxIIFl4zv9sgLVZUNy7VvKNekn4bngIvjhj8Y5Cef
 Ww/tgPwf7GDAFjx3FDtvPu+yb4HlvhXB8H23SI2Bb6YJR5SbVLOpAcC6FEg/MA1xCFxVBxAsVzA
 TQFMLGuXNs/qEiTQWxvk9XETpc43ygHmIHI0neCQki6cY/XqQkOdnWZR8Uw3FSfMDdbya6Zemhd
 ODW6S1Mt/++q1TEqe66x0D+bFOSXL8rq8siAQbqUCprosgbeO5lw/pd6G5gGfo+n5KCUYXYLJnw
 utXsAqnaFKinAG0vZ8w==
X-Proofpoint-ORIG-GUID: 7nodpsZWyOrHW6ehs-Nr3CfBoQDDfloI
X-Proofpoint-GUID: 7nodpsZWyOrHW6ehs-Nr3CfBoQDDfloI
X-Sony-Outbound-GUID: 7nodpsZWyOrHW6ehs-Nr3CfBoQDDfloI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[sony.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[sony.com:s=p1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3113-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:lihongbo22@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Yuezhang.Mo@sony.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[Yuezhang.Mo@sony.com,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[sony.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sony.com:dkim,sony.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,TY0PR04MB6328.apcprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: D6166357879
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On 2026/3/30 15:32, Yuezhang Mo wrote:=0A=
> > This change fixes an issue where domain_id was not shown when=0A=
> > CONFIG_EROFS_FS_PAGE_CACHE_SHARE is enabled, as this configuration=0A=
> > is mutually exclusive with CONFIG_EROFS_FS_ONDEMAND.=0A=
> >=0A=
> > Both domain_id and fsid fields are present in struct erofs_sb_info=0A=
> > regardless of configuration. They are not set if the configurations=0A=
> > are not enabled, and remain NULL. Therefore, the conditional guard=0A=
> > in erofs_show_options() are unnecessary and can be removed.=0A=
> >=0A=
> > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
> > Reviewed-by: Friendy Su <friendy.su@sony.com>=0A=
> > Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>=0A=
> =0A=
> `domain_id` is a user-sensitive information for the page cache=0A=
> sharing feature (much like passwd), so it shouldn't be shown=0A=
> in the mount option by design, and only the mounter should=0A=
> know what it was set.=0A=
=0A=
Oh, this is part of the design, not a bug. Thank you for your explanation.=

