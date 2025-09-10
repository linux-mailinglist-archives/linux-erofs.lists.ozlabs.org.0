Return-Path: <linux-erofs+bounces-1008-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42902B50DA4
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 08:03:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cM99M3BjFz3clR;
	Wed, 10 Sep 2025 16:03:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.183.30.70 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757484215;
	cv=pass; b=FBIjDyCOODyXist/ge9Go06+mjn5XiI/bF4kEU6j3CVIPBNG2ZlXGEX9+VR/eGd0Q0WHTuzDAkmZeiyA7LdMAMDeWu+lNMT7KnGfv/1EmOaOfoBh7CWovpHEplGDdIdFKRhFSBoin2tURnFU24hYJ/1ynbw3a2SJlDHb0KXO1cHlTojlvjyPIxHbLiNBL7MdzVHFHBkoqb4s4nG+vX7NKwxmIjAH7mmIXGaAIX7BiHgXe1zKKKPJF8Fkcvk4cZSYLm5wUXkbYsmWn7UaMK4VD0o3pEedregGSHt0Y4pLd/XUzqvsIy8yLO1+SzOHhinmF+dNacbK9c7nm2ePci/JMg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757484215; c=relaxed/relaxed;
	bh=HPXbGs0fLOiv8pgSvz7lHBqWEqfs0tX+bKUJwagrwfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mG6ptnQtDIKl9Qsoj6b7Er1ucQ6+aQMsVyflXaA/XhgaRb+mRxf2zw/GeoHy7mC4Vxfrlbmlu1ohFY1iyLQHQ8h2yxyUwfgwN+Gdg6QYnZo89/MUntJgLdbikAYQ8CWGRGvYghBsJO4ZoQEfRuLluwojnyyLSsol3POktYSzmr4+UMYxQ3PKA8edTyC9+MeCauGbw7HDhKU4eNMFgczIE77kQMIfJHOGrqIzjYmF3rhRkOYX/agHtaxQMDT+dzALLMmYdtkTsR4/Nz9Q82PRdskKZIBuQnTdmnahbGKOzfWEXM5ECrRCQLkUm4TRXEyOIwQVG+Q/PmYZVgZnKbGrog==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=DncBgedb; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=DncBgedb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cM99L0STSz3clL
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 16:03:32 +1000 (AEST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A5qpl4008335;
	Wed, 10 Sep 2025 06:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=HPXbGs0
	fLOiv8pgSvz7lHBqWEqfs0tX+bKUJwagrwfQ=; b=DncBgedb1PjBs4yPeO954uJ
	vugzhEMfI2y9MmK0aTVvpNiIBw2XKPdvxSZAV0+/qyFnUE7nhJpL5s6JIQ1EBEew
	sx3pNmPinQU6VsDcb3zzVGdgYepcR9XfB82wVCX45h38hYcrzhygrDD523EjcSej
	OSKOI7luppvLHDaRTxIlkGoCeq7oWKSRTM7SUvaQbCvmUszF+Opd5S1AEY7ery+s
	ay2wUP8a1hRBZ3vNFGCFnEeOy6iQIZBI3k5rLiQrHpKEZGlvte72J5GSW9+gcpCW
	5FFDkaLuJe63q8AA86KBL1nAkWqnCfhkWRvrSqNGoqHyHFI/Tt3UnH+NXghBxdw=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012018.outbound.protection.outlook.com [40.107.75.18])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 490ac3kcbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 06:03:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5hM8NrQ6MA94hYjCud52NSlVd4hFqgbNp7SDsbm14Qu2mqrk42yX4ycLi6xfgYYBpofW6ByR24hVevdBdeeaeP7i8/aTAU+TSjr8w2OCEqNGvc9r7s8vJ220c+4gRkwT5Q3oeFGYJQx+AtE39UfiGIs+HEtI6Wv8u4ss5HejTuU4xAkzIslkdJqjhXUt03lvBFf2UyCmiqt3XqK2gW9zqlSdDHRkKQR5uPhdHD0muM43u/n3pzOjax0TIUrp+wiy9GVJRuKDhYyeWH4ndczKSiyhiEKLqFrRojkvZwdt+3xHfj4KNOgo4wkVnSWk1rFMMKpjCRVO1lSHDtaRl6h8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPXbGs0fLOiv8pgSvz7lHBqWEqfs0tX+bKUJwagrwfQ=;
 b=RrfGhxyf46evjIpp9PHMFaLSWWRXGjpiM3JvXiAySBAXBD4M/pd2UU4hjQC9hsjz2LrxZijru30y7PXdW/epiObQTfxkoMOpDpp2zT09O7W78lX1ijkMipMxW9vQS6nL6F0y5SmfYIxojQWg8F13H3DzaZw/TYJMQkH//kz9pBrUPMeq3B7V6qqiF7Hq1mw5dTnmVc2SmvXAXgQ3df0hbpmcAPX1XhL3MoCUl/JCr+YNZ1lI9NIDNSQssWM4DnSP+9XoYeYQHXfLOKU4gePCN/34bSmOdFsl3rj9EuvvcsgwHQTa4Zx2GxbIBm1fQx3hlICjtuusOpMydyUVlD6IOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB6362.apcprd04.prod.outlook.com (2603:1096:820:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 06:03:13 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 06:03:12 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v2] erofs-utils: fix memory leaks and allocation issue
Thread-Topic: [PATCH v2] erofs-utils: fix memory leaks and allocation issue
Thread-Index: AQHcIhC5QiREeD+2CEe0KSvWq1W5BLSL35IAgAAH56Y=
Date: Wed, 10 Sep 2025 06:03:12 +0000
Message-ID:
 <PUZPR04MB6316800FA85EBEE85F6EB24F810EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250910050545.735649-2-Yuezhang.Mo@sony.com>
 <e0835c8b-83f3-41bf-bf67-f163b4cfb229@linux.alibaba.com>
In-Reply-To: <e0835c8b-83f3-41bf-bf67-f163b4cfb229@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB6362:EE_
x-ms-office365-filtering-correlation-id: 79fa03d8-a6e1-4d3b-4a3f-08ddf02fb9ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?hDDj06kE0F3ZjQMeb7pEFfmZwe7OzmUyxQrkf4e9ZSTNqXWPCNWhdhRnAD?=
 =?iso-8859-1?Q?RDct2AqUZG2UshzgwYjkh566d5X0wcPlNM4Ec8XG5cOFjKwb4oK0W8IIVY?=
 =?iso-8859-1?Q?LnHPfNcn/lmb2WpSe8Nl1oFGu1eB6+kf1m49kq46IRqdSg4UwfBc4bzIRt?=
 =?iso-8859-1?Q?S42ju/11p2lj8t4Kq2MEq3F5WHfY9TLS8FFaBLv7KU1NtTb8MElIPGkT0g?=
 =?iso-8859-1?Q?SphKI2eghdJ2biPNWjb/PqXDy+Bw37bO2QMogFg39lSFD9e8anxKQGxHgk?=
 =?iso-8859-1?Q?iVmL9S/EV9nfILtlLomcGEi89shiMy1wgfsjKI14fgOgS4ZqS+8c1BRLbM?=
 =?iso-8859-1?Q?cpjhZSYl1MTIRgcfA1Y5lnu+31egBL4CGnSiFIpP5i7ERcZs85mtZ65tF1?=
 =?iso-8859-1?Q?Nv6PmVj8/tVlVK8xlFQEkr8aYvn57L+cJkDvSy0qL7nfHw3KhstL6vFTaG?=
 =?iso-8859-1?Q?A941DYKAYE2P8pph08MiQYMiAY0VDB6ByCse4mQx8WBAqnTIIy1Dar32UP?=
 =?iso-8859-1?Q?KvUMDOlZd9Y8VVj+BLH1QwTtGGI6h5/G0eHKh/esMqKE15OleUxqRrBSPb?=
 =?iso-8859-1?Q?xvNmxfuIPswZM0w/nYtgFOdWsQr3R0ceqhdGCe19NKD1kfywotKJt+IMyx?=
 =?iso-8859-1?Q?3a89VRxDvWNgv1hVGvUnWiYVMvyEL+bDiLYwviwIMfkKo6Gzypz2gqHFwp?=
 =?iso-8859-1?Q?5XMxQlsalqVzN+dTj/Gkq8HHiI9g67T/V0jX7wjx+uG55qUeCDVahwivJi?=
 =?iso-8859-1?Q?R/jY6Kyscl6buLZu3GLrIgF8uSCKZg8vVvLbsg+xD953IK0NEgMSl8UYni?=
 =?iso-8859-1?Q?dTSXlxPVFiLpI84v5c4bCc8WrfY8EIm5dKHyh1euxDp4mFHZgccZV/h/HC?=
 =?iso-8859-1?Q?ESr9iAhNTBsSUYH7h3fdjLpGkXwf/5h5reUUhnqjPdbXUzUmxvD3RigWPK?=
 =?iso-8859-1?Q?kILR8FJfPQLxiffPG58DiWTPdymvHbHibLi8PIDWaUl5tmFJRrOuGsXbKw?=
 =?iso-8859-1?Q?dFz8evx4S3Zz8g/3FxqvGfSdzq0RlzXHZpY2Y/bPviqQCzPCCK9/+XiuM1?=
 =?iso-8859-1?Q?lgnlQ4FjXjI/4olZQW4cTAGPyx+InR0E1w7E/13D5OtO4y9kMtxDUyRbq0?=
 =?iso-8859-1?Q?Oy4gVOY72COxFtP4k+JGlOoH0wZ5UU0NWjIfwHV/mQKPR2zlk70xbV13MM?=
 =?iso-8859-1?Q?N78tqV44547GNI2kFy+QBScHDl58CwuhS6cd82b/gyA4WJcLmlEYYBaxZ+?=
 =?iso-8859-1?Q?IsEDFlJLLkrClNyHNj0the/D5g3wOQL4O7AikpZArhMrfjHGC9I3hz0jDA?=
 =?iso-8859-1?Q?+IPWDHKMIbsnxk7m/ZmwQDqjIjKsn8S4/BIwuGZoEWVq6L4KhXpoyNLnT8?=
 =?iso-8859-1?Q?uGJK29l+chXZQildv9mzuGiv1z7wroEZ5Ys2QM/UCl1H60H6Bn5QzD7TpT?=
 =?iso-8859-1?Q?EG0R+nj8ZFn5Eg2z87oEFhBrycVTjxF7nvKQBteVAReoxukhggaEEdfKld?=
 =?iso-8859-1?Q?DF7nqlUpqmsgFJLBLryBt/5u2yz2pkhgqWKzt5A7kvkEan44bZZA6dnvcY?=
 =?iso-8859-1?Q?Cda8ggc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2OH1Vh50papQvpKQKMyFqUWLkiUlIHmi2z/F/wCFc9sh6AeqOUAdv9OfBX?=
 =?iso-8859-1?Q?YWFmAQ4D6EApZT2zHghBl1HpptH4Ope1ULd70cWrvzMop6YuJVZK2+trB2?=
 =?iso-8859-1?Q?xoZUFGUsYgsx4wimD/LvncCcqLP0m8cAvjVCN3hgx6W4l9lzWq0MXs+la6?=
 =?iso-8859-1?Q?cEcfem2DfvUp7ci2Xj1LV0EjnpQQKSyqLcLzM9vqJ6LmYJwfhB8KIJVuBQ?=
 =?iso-8859-1?Q?n6c/6tWWvHuyRDkxwsXq+Va1uR2WMBmabhSJvu6IxyYt0DDWIwxtGeuywX?=
 =?iso-8859-1?Q?CRp4QHDofBdxVIlBR+XfMXOiYAOhRuW8xIB/yrvHLI8JdWzFlq9J3wdScu?=
 =?iso-8859-1?Q?lxSfJmx9H9ku3WUGDxZZWrSNryGvkCxzpnmqlSAG6PBp+YD1UR7HmfkfmZ?=
 =?iso-8859-1?Q?f3HIDhNy1CKpnFzNVP0mdGf2PrfcLWMqmSiFtEztZT5qXA0Pq4T7Zmde+u?=
 =?iso-8859-1?Q?2wLKEY+kIwMcxXV7mV9neipAhn9glHqBdem7y/ib1s5/CSZx16dH5wJlEV?=
 =?iso-8859-1?Q?C6hC65ClPsqsemSx3zRilbo/mFcWDlbLPkNcjAita044OQa4LobvEaDOmP?=
 =?iso-8859-1?Q?Mqxc3e4xXI2FjqG+BBRWEN1RiadsnDLJlTt7ltvmDtRDeLW/6AxGQqZbDr?=
 =?iso-8859-1?Q?c3YcdBvAwPUIE8sMBOK5vMvJmWfhXPp9IVloe8uqy6+Zhfws1be/IFozaj?=
 =?iso-8859-1?Q?Kt9CzIbcPXm2LGiWCCyK90mJwEchDO7hJPKRXdDsDlxpX+lZKr5sjcd8ij?=
 =?iso-8859-1?Q?HhurVgDl/2aOTgHfsvnbtyLmVuVd7WtLfYqhLA9XJoCjkcaAhSInbPu3FF?=
 =?iso-8859-1?Q?r+xEM4OVnw2Mg6c9GXXoXnTdDGmx/x1DcqF/tfa5wBIiYLCk+LBcr1GVI4?=
 =?iso-8859-1?Q?LZCufitt437Cj00k9StArBSkfcY7pNag1JWsRBIQLde86xFAxoQus8aUNH?=
 =?iso-8859-1?Q?FiHig+YVnvEJ+N8LQYnZcqRDfs2fabvpasqwbnt54voKtk7O+oVse4sdVZ?=
 =?iso-8859-1?Q?I8khjyqcgtwc43Ej1LeQFvypLSNrWKvmVis6YNpjnKwPMihiBbyFK/7Uaw?=
 =?iso-8859-1?Q?rb+uT6lMdCNybVJaTkreVsrMll4E4V7Jol0AVVpAEzfcBPGLX8wzFOKpd6?=
 =?iso-8859-1?Q?e2CdRZvFypVmty8mTduSefDW3CTK8OYhlocr+wyroibxxP8NNzJEkWgS29?=
 =?iso-8859-1?Q?k/I2PebEpmR1YqjYV07SjT0f8DUwuCY81uPOfS9+dv5WNFzcauRJFbbAS1?=
 =?iso-8859-1?Q?j+5A/n/Or31IfaIKcR3yJDtPIEjVy8fb7hGAZ8GfltbBxYmj4LIzmAyqti?=
 =?iso-8859-1?Q?lijOyJLHVL2Amna9xDmwNgQ4Yh9sXAZBreDMJKjx5+IVHymdc8j+UJkfhF?=
 =?iso-8859-1?Q?GfZkF5fGi4CmwavH9iBORnoPP7KK+XjfW1gpKlpdnfhyfOA92w9bUemZ5V?=
 =?iso-8859-1?Q?fmsjHv2xE2FCeaXssd7G9RH52hGMCDQnLFF8rEZo9i6WNt5CQLRbRfvi85?=
 =?iso-8859-1?Q?QOjVuD3LQn9F0h3ZB6Ua9SAD1JAhBoHWQU0xg0OAr1NaHhvtrlfMlhcy/i?=
 =?iso-8859-1?Q?j782zwI5ApQbyY+EQgXQqKHefd/Ktp5qXG5heR24CieWZucLA80tMKaCy9?=
 =?iso-8859-1?Q?sSmCGKaFAjUABKBWWUTi3JTIjnpt1IMn6tXXFW3AOm9UyQmqD3Nn5qz7aB?=
 =?iso-8859-1?Q?qpqzelKahgEBS2KGhYA=3D?=
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
	x7OZlUWvgll8sR1kWIfq91Zl73lK0R0UU/pI4hJMin8+LjtAhEiX2jkez++7Tmey/bx1UgHT9rMOgqKs1q/4klpqZvp4y3j+0buMC1OGPo/0VcLcbc85EJFG5RSw2RiAmMF6hBnC3a42UKK9EOfZ4t+2uPdHbLuOxKQsVMJgp9rRWQLLQsPZELV2xPadS7WWmPiwvfrEYvI6WrxSyibTA8Z+QXAFP1s9/3NHR93D6KLr43IocTJsdqqXvAD6tfS9DIrZ7VUPGFmw5+Qbw0S3OJGHMYDHNmxCI+oDKHDsmJSnskYzzeEyb0dmukATswF8/7iUWA2SZjTIWFNUefRpf9JVlsJoOLLGbjkodc4GZEWoxZZdHwlx/jJ7snWIKdbJyxnz1JyC2BM61JTaKBB9bExgucbOn1fGg1e4d1MRT5StZbvniiKQq69wwFj58zG09J4RBMNowOQcvR31YNF0ET2TSfPChO/vMUYur7CPiMQPeDBpXNnqQ37tk2/mJmcVxQYS/y/q/uHjFI8WL/OctV9ZS5fCf2MRiWevX5eGDPBCl8oa2XSfzCBVLiSSvi3x3AaZ/GL/ZvSOFelkqFeqBGaRLkDZupKbEc39huGGO0Si0ucD5yklR1B/zIQlPxvK
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fa03d8-a6e1-4d3b-4a3f-08ddf02fb9ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 06:03:12.5988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5I5iyhB6MRrbxDzbD79xmRDcsvTozoxK0yjmU2rKWwOukcz1pML0tmOxVXcslS8B4dX/gu4AMMdE0/isRET2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6362
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX8FfMGfyjEDlf 88S86ThDttnUfqOyUfpIVA5ZT13m9+iRrvC5s2J9uo/DDfjmds6qs4SMBBQYGCKGa7nfX/AT4UL UNFVprMjhKZ2nzD15toHk0T5hKK9NZ5bogpxwSaySBPhL4SOcSp3uPPZsRsbgX4ZQz1G13pMVo3
 YL9kAaOdEcRuQz6qR3Ft82Tvy+Qq05v4uwqChht3MXvk8oninje/qk6b8MScivuRKGfQXmsbSI7 9JQzJLAq/bzy1JLqqg6OdIvKdZ08Qf0VHUhuPsyrbjElCXYWCvorGz3UR/rNDBKc5XXWbLf0YoZ pVf2+WbZi3utjOAnDYEQeYp5e9YBSFtdUZ2RfvG6cbW05Td9I+ePOy8aWU31eB9klnvciAbOzvn w6+NXVFU
X-Proofpoint-GUID: BKRJ0-6ng1bjOZ5hJT1Po_TFlenPew7F
X-Authority-Analysis: v=2.4 cv=W+04VQWk c=1 sm=1 tr=0 ts=68c114aa cx=c_pps a=S04CvH6IhoR7DMoStbvzrg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=kNUWu52_tWfjfQizOX0A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: BKRJ0-6ng1bjOZ5hJT1Po_TFlenPew7F
X-Sony-Outbound-GUID: BKRJ0-6ng1bjOZ5hJT1Po_TFlenPew7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/9/10 13:14 Gao Xiang wrote:=0A=
> On 2025/9/10 13:05, Yuezhang Mo wrote:=0A=
>> This patch addresses 4 memory leaks and 1 allocation issue to=0A=
>> ensure proper cleanup and allocation:=0A=
>>=0A=
>> 1. Fixed memory leak by freeing sbi->zmgr in z_erofs_compress_exit().=0A=
>> 2. Fixed memory leak by freeing inode->chunkindexes in erofs_iput().=0A=
>> 3. Fixed incorrect allocation of chunk index array in=0A=
>>     erofs_rebuild_write_blob_index() to ensure correct array allocation=
=0A=
>>     and avoid out-of-bounds access.=0A=
>> 4. Fixed memory leak of struct erofs_blobchunk not being freed by=0A=
>>     calling erofs_blob_exit() in rebuild mode.=0A=
>> 5. Fixed memory leak caused by repeated initialization of the first=0A=
>>     blob device's sbi by checking whether sbi has been initialized.=0A=
>>=0A=
>> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
>> Reviewed-by: Friendy Su <friendy.su@sony.com>=0A=
>> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>=0A=
>> ---=0A=
>>   lib/compress.c |  2 ++=0A=
>>   lib/inode.c    |  3 +++=0A=
>>   lib/rebuild.c  | 13 ++++++++-----=0A=
>>   mkfs/main.c    |  2 +-=0A=
>>   4 files changed, 14 insertions(+), 6 deletions(-)=0A=
>>=0A=
>> diff --git a/lib/compress.c b/lib/compress.c=0A=
>> index 622a205..dd537ec 100644=0A=
>> --- a/lib/compress.c=0A=
>> +++ b/lib/compress.c=0A=
>> @@ -2171,5 +2171,7 @@ int z_erofs_compress_exit(struct erofs_sb_info *sb=
i)=0A=
>>               }=0A=
>>   #endif=0A=
>>       }=0A=
>> +=0A=
>> +     free(sbi->zmgr);=0A=
>>       return 0;=0A=
>>   }=0A=
>> diff --git a/lib/inode.c b/lib/inode.c=0A=
>> index 7ee6b3d..38e2bb2 100644=0A=
>> --- a/lib/inode.c=0A=
>> +++ b/lib/inode.c=0A=
>> @@ -159,6 +159,9 @@ unsigned int erofs_iput(struct erofs_inode *inode)=
=0A=
>>       } else {=0A=
>>               free(inode->i_link);=0A=
>>       }=0A=
>> +=0A=
>> +     if (inode->datalayout =3D=3D EROFS_INODE_CHUNK_BASED)=0A=
>> +             free(inode->chunkindexes);=0A=
>>       free(inode);=0A=
>>       return 0;=0A=
>>   }=0A=
>> diff --git a/lib/rebuild.c b/lib/rebuild.c=0A=
>> index 0358567..461e18e 100644=0A=
>> --- a/lib/rebuild.c=0A=
>> +++ b/lib/rebuild.c=0A=
>> @@ -186,7 +186,7 @@ static int erofs_rebuild_write_blob_index(struct ero=
fs_sb_info *dst_sb,=0A=
>>=0A=
>>       unit =3D sizeof(struct erofs_inode_chunk_index);=0A=
>>       inode->extent_isize =3D count * unit;=0A=
>> -     idx =3D malloc(max(sizeof(*idx), sizeof(void *)));=0A=
>> +     idx =3D calloc(count, max(sizeof(*idx), sizeof(void *)));=0A=
>>       if (!idx)=0A=
>>               return -ENOMEM;=0A=
>>       inode->chunkindexes =3D idx;=0A=
>> @@ -428,10 +428,13 @@ int erofs_rebuild_load_tree(struct erofs_inode *ro=
ot, struct erofs_sb_info *sbi,=0A=
>>               erofs_uuid_unparse_lower(sbi->uuid, uuid_str);=0A=
>>               fsid =3D uuid_str;=0A=
>>       }=0A=
>> -     ret =3D erofs_read_superblock(sbi);=0A=
>> -     if (ret) {=0A=
>> -             erofs_err("failed to read superblock of %s", fsid);=0A=
>> -             return ret;=0A=
>> +=0A=
>> +     if (!sbi->devs) {=0A=
>=0A=
> `sbi->devs` may be NULL if ondisk_extradevs =3D=3D 0? (see=0A=
> erofs_init_devices()).=0A=
>=0A=
> I think we could just introduce a new `sbi->sb_valid`=0A=
> boolean, and set up this in erofs_read_superblock()=0A=
> instead in the short term.=0A=
=0A=
For rebuild mode, ondisk_extradevs is not 0, `sbi->devs` is always set.=0A=
=0A=
Is there a case where erofs_read_superblock() is called multiple times=0A=
if not in rebuild mode? Or will there be such a case in the future?=0A=
=0A=
>=0A=
> Thanks,=0A=
> Gao Xiang=0A=
>=0A=
>> +             ret =3D erofs_read_superblock(sbi);=0A=
>> +             if (ret) {=0A=
>> +                     erofs_err("failed to read superblock of %s", fsid)=
;=0A=
>> +                     return ret;=0A=
>> +             }=0A=
>>       }=0A=
>>=0A=
>>       inode.nid =3D sbi->root_nid;=0A=
>> diff --git a/mkfs/main.c b/mkfs/main.c=0A=
>> index 28588db..3dd5815 100644=0A=
>> --- a/mkfs/main.c=0A=
>> +++ b/mkfs/main.c=0A=
>> @@ -1908,7 +1908,7 @@ exit:=0A=
>>       erofs_dev_close(&g_sbi);=0A=
>>       erofs_cleanup_compress_hints();=0A=
>>       erofs_cleanup_exclude_rules();=0A=
>> -     if (cfg.c_chunkbits)=0A=
>> +     if (cfg.c_chunkbits || source_mode =3D=3D EROFS_MKFS_SOURCE_REBUIL=
D)=0A=
>>               erofs_blob_exit();=0A=
>>       erofs_xattr_cleanup_name_prefixes();=0A=
>>       erofs_rebuild_cleanup();=0A=

