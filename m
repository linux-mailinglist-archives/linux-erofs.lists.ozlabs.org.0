Return-Path: <linux-erofs+bounces-2625-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA5+BH0bsGnufwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2625-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 14:24:13 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE75250294
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 14:24:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVZN924dxz3bmM;
	Wed, 11 Mar 2026 00:24:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.165.32 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773149049;
	cv=pass; b=LPWm1GZ/H+nWavvWvjC19rIzjb5I0Kq0zhyLn3g/zGRxp64xJvsSNZCHlPDD9FFySGT0BGVH5Ot9hu+LdtlVsHc2FElsTBqGmc7zQ9MhLYPz0BVK/IpUmGaAFEZWc4HTwoeGULZpfLLjPbXbExt1houGzg66IUXvadf8SNFJbyOrqNFsdiFpHjfolQrlCO1GytV0ucKlD5YT0PKJTWYNe46JqJdK8UzTduNO3+IMqRej1BohEUUEtBx2xGf1SMP12izoh7NdsQOo5ZHND8jYCsZDt0NgjLsUOLYTAAd5VCq2Gt1wrZPAkqgYI8Wg6xOnuQXf9UuJ3ofs1vzQjeWFuA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773149049; c=relaxed/relaxed;
	bh=0wHimKomilJLoyXBh4UYx8NImrmifztyqfE3GbkvMk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nB1lx7YIp9bsZpoZI4kTEMuBvQ1muMwYc1O8zzOgBNqx3Qp3VIghviay50ji6RnlIflC9NqZnzS+tlDyNa/NY4FEV+FKfTygv1Jg9LXqBCOwDS+G7Um4JAPQBQnbszNTt1uzDYHVxQTt9g5/TXHMa3kBcf0Nphz9TJ+kcuu0KBByl9VxAfaEwy2V9UFhL0jZCe5imS3ZVWbwV+iMNVpG93RwquW+ug2DnxqMrEz2jFPigjtXWXB3Mb2dDOtKpZbZ8ASHajNWW5+AyXCHYd/fGMB0FEWTWlLGnsAvRrq+koNOIAsl0I9j/u696gtDUq0ZZApprH4A+DFgbJuP8LIkkg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=G8xh4Unb; dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=kD+yibV+; dkim-atps=neutral; spf=pass (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com; receiver=lists.ozlabs.org) smtp.mailfrom=oracle.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=G8xh4Unb;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=kD+yibV+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com; receiver=lists.ozlabs.org)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVZN75wb9z30Lw
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 00:24:05 +1100 (AEDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9K9Tu2347887;
	Tue, 10 Mar 2026 13:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0wHimKomilJLoyXBh4UYx8NImrmifztyqfE3GbkvMk0=; b=
	G8xh4Unbg93cYXPa7AmEzXB4RJd+Y6vG1iJ6esD7sCipAliEuIGd/jTjCSmi22nY
	eNGCWgU1wS3Ab4rdH0fyJuFIQEGoW8xlCWUFAzfFgptUtcP8YuVu83nPP9+P55xM
	EnxUe/BCKcMy54wrGOkWfMZRApyApGArK9axGxFu+HtyM6791n/gXrAbVPuWm7sm
	E7PaX00K7njWa4VRsA1XUhJcCbKh2hEP4+35hgzTP5Y8ABXYreGeFwt4NJddL+jF
	NHhbjiARnb8CLAvAx6e25dOaonbjrdpoL67S/vXjVkCOdW+j6R919dDxEIuB6EFy
	Yn9Z2ZqVZoha3XikDesY/A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmmaaskp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 13:23:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ABsDoD040456;
	Tue, 10 Mar 2026 13:23:55 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4crafa4v28-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 13:23:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wk6KL+hC1gRypI01qHiG1iXN0tsNLXeu1d3hCVSJOcrw+EoW6ay1oVKMsI962qXqjPT7C4g0XQYtioMVVHCTGgr+TBI7r5ukesDszE5OhLB/kVmIMeJPLXhk2Vw6kpqPC+GyKNUgwMcwD95CJ0d6uvcCvFFQvAl2h3z6k546KT9ku5qfOitxsrq39dzHxoAUk3NhEw03dayGL+bjHrSJLhN048DN1pXFQXA3d95Xv3QiO5PNXy3wT78JwzCTwdfl94UdIiaS9nHOlcSvHQ80l2UiErbAtE+3nkgkMtoGUoiv6BbbcsD0LepLc096VIU3xfDA229HFWla0xXnfUBt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wHimKomilJLoyXBh4UYx8NImrmifztyqfE3GbkvMk0=;
 b=Ay0RaAgDqWK4MZTSeRiWTkw91LPj9NH+3Yrh/iW8c7Cnw/oRHuDS84M0I9NL2eoF6xJaeoLnMjIhhBvD6JeVplASFlPU/5nkjvdvvwPWx0iLj3c2GO+SvRXVXSN+qCIa8B6a1sBj7Oj3V/w1YiP82GPBv8Qnb24WD8i+OZRlBZmgjvSDKd2TwQxERxr5sEnRJBz6M9LdOFHDl4SxCsRXH/Pi/7ZoXIY1pUH+4SbPTFpX3fu18ISEd145br7wZ1o4Uolzf6BtFNshc3HgajLGwOhYN9hJS3lG4tzsrlB0Uu8Wf495KeME9PBKdxQ/j8iQtC3mIlJt4qeSPABst7dwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wHimKomilJLoyXBh4UYx8NImrmifztyqfE3GbkvMk0=;
 b=kD+yibV+JHISSuKwaUiVu+wkM4vbZLQsTrxDO5u1F8OqfqNpGdyB8Ai+rssjQGi6j2clSfLc2IHLIV0MBMhTzV2RnMxtHRb5u3SSG9ranMdCwH4Xuzargep88cJhk4HdT8bDeOr7Cojy8HqWW7/uewIBQivVHSQWpfq7yUdIr6s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6688.namprd10.prod.outlook.com (2603:10b6:208:418::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Tue, 10 Mar
 2026 13:23:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 13:23:47 +0000
Message-ID: <d807a2d5-75f2-4d67-b2d1-dfb6b9c6dbcc@oracle.com>
Date: Tue, 10 Mar 2026 09:23:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/61] net/sunrpc: Prefer IS_ERR_OR_NULL over manual NULL
 check
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
        apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
        ceph-devel@vger.kernel.org, cocci@inria.fr, dm-devel@lists.linux.dev,
        dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev,
        intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
        sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:610:4d::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: dd21a29a-1151-4daa-d79b-08de7ea842e6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|22082099002|7053199007;
X-Microsoft-Antispam-Message-Info:
 c5p0iL+8MlDzs+ZovlT5nmOTEU9H91XUrfEXWFRBohtH2yIpTc9x1mr45OcD2q+aW4pxUtQ2Lzev1w44JgzGsTULVnKbjkpQ66Nw3dsuRrflFq5eyUxrciecC0qDbGvUXj4wPESnIGXNyT8RAPnMhwHAfbfqfeoqo7L12QtjK0gyXeJpSk6Wxz8UxthlnVvM6l8TwCDti1zn9h2JtWrZZaNmbtNw/R7Ou9fz9mcbSio92X+KdHpKbExkZmbfLlf9ZLHmjnzHiBdmPZlBXsozBgJypouHCAopP46rOy9ckxyJe1a1vuE4GQVpVoyHtal6YhpW3XtYV8uQykUVBmTCRBO1greHlJia2aiUcdrxyYhqAzszvuxrsnkZ6eIaZJZaMp0YBCtrFPSVbKj7sg/+peK7I1RAQRtxScZkd7/h+wAGKARMNEpTWwh8F74h5XPaRDtv8rK/aH+c8LuVoOKOF2rAJ3f478Vcbcsjq46mAKAZt+CLVpdyCUHXJJa9tsWv3Kr6wajO6bAvwi6lPINPoAtcV46xpUFighDAsjNTD840e0PrvhWcLuhCZ2JXj/rEnCFLoULTpIl99TDUCnEXpM9SUcYwp2vlkYwe7e/q6vaeDupw0vkZdiNU3DtJAfB1Qwvrqjjt+n/PWxO/oknZk7JN1h/FgHGqDbKcjfTmpUz7Zjn899NgZ5d/TTU+5ps0MThXa53xitH6uQ7x/mv3iVCSvYlqRMlasnuq5N+V+9HcMBIubAbTIPaA3ffaL5uE1HfLE6dDAIH9caTr8YP4LA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(22082099002)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aUkvb3BmQXlycFFyYms3cFIxK1BscVVNVk42MW9DeGI2SURjdmIyMkw1eWtm?=
 =?utf-8?B?WGVva08rQkgzVGVERjhaUHRRSXpUSFBOTW5UVGdGbXhUMGF1WEpvSkk4QXFw?=
 =?utf-8?B?clVZOTZnWWduTmFkazE0dDE1clQ4aUlwcTRWaEU3QVdNUEhIRW43SXdOWVZ5?=
 =?utf-8?B?NmpNMVN4NFpQYU9lY1owUnNuYVdEYUhNbm9jTGpoOGZYWGlVVVlUVXNBLzNu?=
 =?utf-8?B?aWl6N1BkNzB1YzhnM2d2akJObVg2N0V6dDRISnVmS1R6Ykx5RitOc1h1QTFE?=
 =?utf-8?B?Yk0wckVrejQxSzcxdGJhdXhKWURERXRkeVNxMFZqakY0NjZ3VHlJVDFXTUFM?=
 =?utf-8?B?aVFITnlyT2JxOTZ5RUV5RFVUQmcyNkR3bFV4VEkvdmRyc3NPZHdvVlhaU3JE?=
 =?utf-8?B?TnVwNzNzdEQ0cG5iMG1TMmxRMnJ2dUN1bVFxd05NQnZ3ZkZDcytFazVsY2Jh?=
 =?utf-8?B?R2lFUEZZTEh3ZTlFcFVvdmpwc2pBN04zVlpJZ0NtVUZXWmVVbWRpOUx1Ym9y?=
 =?utf-8?B?bm93bjg1VG5ma25Iak5UbG1mOFhLVHVmRHpRd2Q3Q05vOWhTbkpCR015L1dZ?=
 =?utf-8?B?QWxUS0Q1azlueTRIeVBGR2UzQXJ1OU8yV25NdjQ1eSsxdUhSVWc2dEExU241?=
 =?utf-8?B?NGc4VW4zaUdJT083RWlydjJyME9TTXcwQkEwVjNXQTFRdjNGc3o5VFhHTkJZ?=
 =?utf-8?B?VWs5Mzc1SE1xejFOdlhTNHhIOUNRbForaFhHTjQ0UU5YOS9FekYzSWkrUnd4?=
 =?utf-8?B?ZnNhTnZkdG9iOGtJUXdhRER4UzBKVzVsVHZqdS9EN2dmR0FZOXBlNkd3R3pz?=
 =?utf-8?B?b2tVbEQ5cE5mZ3dQOGZlUldxdUozTDRQejFlNWM1UFBpRmpHWDQ2UEs1YkNr?=
 =?utf-8?B?QTlDNWtBdkc3amF1Z1pJU1hobHNRV0VXRWZhVlliUDYwbmpFK2RJR0J0Y0k1?=
 =?utf-8?B?bnFjbU5BTm51SCszZFdTRnVtcC9jMU02Tm83VWdUTDIxcFhwYXl0eDMvN05r?=
 =?utf-8?B?bXByUk81YUZRL3RMQUptdGwvZms5QncvZGdacGtqeFJGYzNQUnRZTWVUb2Rs?=
 =?utf-8?B?YjFhakVubmFoK3NNM2VLR2F1NDF6K0RMcC85TkZ5TE5SdEFyZ04rQXNKUGMv?=
 =?utf-8?B?OWN2bW9yVzFVK2phekZBNFJhcVZKZUd0YStSSlRXMCt2WkNsQUdUUGNycWhT?=
 =?utf-8?B?UXhyM1RxTEQ0dVFXb0tlL3U0WVBWOXAyZjlyU1ZOYUJ2ZFRVUDRqQldhUmRR?=
 =?utf-8?B?cUg5c3NFSXhocmRlVFlEb1pxRjFSbkZza2JIS2ZvRmxGdmJpRjkzWlFqQ0Rj?=
 =?utf-8?B?QkZEa01sdFhVRUZrZmZpa0p2YkNOMk16UUZhaEIrbUViREVjZVhwd2RBQ0Vo?=
 =?utf-8?B?d1o1UlR4MFQ0MzRpa1kxYVI2OTI4bklldCtZaE00TjRGbkVJKzczYXI4RVhI?=
 =?utf-8?B?bCthWXVERlJKUGlrZXQ3YmUvT3djZDN2bVZRRlRGSjhHNzBJY0todVBEeWI4?=
 =?utf-8?B?TS9nQmRsRXpLdHdnU2R4Q2laQ0FZUTRsNXNMdWpvSVdIU0RuVytWQVlZcHZR?=
 =?utf-8?B?aStIUjEwTW1Mb3dDdGJvblVBRjUrSEJwN2xLYmxYM0I5T2ZVZUNSRlU0NlBY?=
 =?utf-8?B?MHM5eE96QjVJSEY1NVM4MUF5SFYvck5qeGNJbVZVN05ZVHlsaGxoUTFiRlNp?=
 =?utf-8?B?SzgzNUllVkJLUFdnWTNDWFE3SjY1cU1YeElCQTh2V0wvSktDUVQ3OFRrMW9V?=
 =?utf-8?B?Nml0dE12ZlF1TkR6M2R2anB3cWJld1QzT2ttZTBJZDlNVUpwN1pTbjBLUVNE?=
 =?utf-8?B?d2Z3QXdURkNEcGpkK2QzbzAvd0xaS01FM0hGZUMvL29uenJ0Ylp6TzJjYnBS?=
 =?utf-8?B?QmVKRFZ2MlhQaEhkMjQwOWpMeDVNL0JYS1RtbzlUSldEZHFxM2FGVCtNYWlv?=
 =?utf-8?B?MjVMR2htYk1kUkRlMGtOem0vZSs0aFBsaUk0RVdaZ2VsbitmQ2psQ3c3bk1x?=
 =?utf-8?B?QU1Qa2VNQ1EzNStZemdaTWRPcGoxcGNHOFZGVkdkVEpxWGZJVTYzQUQ5czJs?=
 =?utf-8?B?L3J0MEV4N3Ewa05wZ1dsTnpZaWhPenhFUHZzdWFUUCsra3ZNVDRZNC9PdHp1?=
 =?utf-8?B?VHh4emdlZmo1SnBCc2R2bGlpWDJobmI1S0NtZlZiTmJFaVdhRlU1VWlEYlFS?=
 =?utf-8?B?NW85WktJTWdZUU1DR2M5bnJoZGs2cEdrNzllb2psTklYTCtMTTFDOS8yeUpl?=
 =?utf-8?B?dnZvZWRHckhMQUcreFhQdjNjdU1nbkwzbElYc05oVGFNYlFIeGxGdG14eWFp?=
 =?utf-8?B?STFwd0Z5NTVwT0NwaDNvaEJWSnlYbTc5QVlZeWEwTjNXaWczUG1HZz09?=
X-Exchange-RoutingPolicyChecked:
	czu9TR8cCjos8TNlV//uV5R5UyW+YnY6mPT6ik164ohnQ64LjUt0KI3sioks1wiudyeKOK0T8jnT17p+I84uLJ9gicu25do+PN3lmzMrRHvzBNDUNLJdfsISpAYheKGPrbzNm68DRTb89Mtim9feKdXVfUC9hCiFUYcikosxcsuxjz3o2OOOMqnDp2wG3e2WVMZ3R9WrUZGKodbV9jlwXJosdQWOTdx7YfTP3EW2WDNwGFVIQOsdXNiwAZ6vXdaTlQiZLIFLbC9FkdX/mXOdO4gym7Ebk7nN5VHisY3B/+aAoKLjyglTUB0MgA/TcbZawRngvdaEgYufRs43pvHWIg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FYJTUfdyiGADLR8GtYrzgw2uJf8HiMCbfqlP9llNLeCVn/3CjRBL66dz18nFaWRhYz3ZBxgEo8mLK4jKzZjA5TZe/82YMAGF+1K6Wqax+vvPlkm3GWij/HZx3FeDeaFYYONbbqVV8owCBAFE56sNXIzaxZiUa3LkSmvEUP5EqJT7yxCp1rjc/qm4m/9TvcZFZb1DA/dIaEm2szKtc6hth65MLLztbdJlOYldGyUL9cfxBjASksnQIENGyaahc993RzHV8L6EpDmQAPnwQnYVt8VbBOCalZNhvSPhivEbuIqvmMNGM/xlew/ev/oxZ5vkxy7MokbWNZKjmrSE3+pBWZsZj2He5AK2U0FX0fhiMrQeMVjWvbZNxXHnvHHxmH/ZPbns0HVu/YWii7x3WNXlrq60GMCjWyQeKjSQWtU5WPDLom8iuxuTzRAprL9WjAjFCQ+ZZcuaczDy4ZGikvjpNxwzjOa+kqyYngC/CUMSKk0oSa7O8PD8mjFvQpUidmlZmHcREkfVp8AAAbQst5ma2PJOAm5rUG0BEnXnqI5Y6b8H3tPiw+nwt+krmF8X93AGY1XjNsK7IdW7c1pze55NN5f9xrA2bIInPVLlp84nXzU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd21a29a-1151-4daa-d79b-08de7ea842e6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:23:47.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7Gfp+Vyo1cEa8SDflP/dFNKhZZU3QS9Fa3d0ys560KjPROZeMkKBZtPdBCPFI140+zhSh6CX+OsbyH6C6s+LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100117
X-Proofpoint-GUID: 2jp1RFvAK7pNvX0n9MUcJdJee5P2okU5
X-Proofpoint-ORIG-GUID: 2jp1RFvAK7pNvX0n9MUcJdJee5P2okU5
X-Authority-Analysis: v=2.4 cv=U5efzOru c=1 sm=1 tr=0 ts=69b01b6c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=SEc3moZ4AAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=WYXT4c1WSOa8yzFlF54A:9 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDExNiBTYWx0ZWRfX5PHXLpN/H0dD
 BGMcq8eAxW/CWgnJao/L40vb5rlTaGSHU2qRRqJnzdsWASk5dcFaAlgdYLF53wtCYM+Wrtd1aCj
 dujkEjjsTFaMzinmHwP60rANe5SUWRocASVnjGXd29CRopxWHI4G9WcjHoqF0gOzMFjmoWnftiv
 Tfdo/6kgxna1LDv1/bcp45Y9GUkhYhXUyJ84H8oAeRjWcCAEapTfB1gKSAmcOzatORncGzyNE/O
 WiVOOAKr9HVB/4KpEXc7vgYgxCkFzZyQQF2z+cqKW0clrFF4FA+yONdhXKTda12ECe22+l8veas
 bVO13wzvjvLhOLKDl828aWi8jYpdVDt7+9t+QgYQDPWrEPVDaYiRx7YfWoL/cIBrfcVQ1d5LspS
 AK5htT0yKG9I+t1h7dIIhmxRHAHIpwxPW1RQtb6XaD+Egk8Ne5c/csgc/NcHqhQriRufoKfn32H
 jxZB/Di1JJVHFvFne7w==
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 1BE75250294
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:phahn-oss@avm.de,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kerne
 l.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:trondmy@kernel.org,m:anna@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2625-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[chuck.lever@oracle.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_GT_50(0.00)[66];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 3/10/26 7:48 AM, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Trond Myklebust <trondmy@kernel.org>
> To: Anna Schumaker <anna@kernel.org>
> To: Chuck Lever <chuck.lever@oracle.com>
> To: Jeff Layton <jlayton@kernel.org>
> To: NeilBrown <neil@brown.name>
> To: Olga Kornievskaia <okorniev@redhat.com>
> To: Dai Ngo <Dai.Ngo@oracle.com>
> To: Tom Talpey <tom@talpey.com>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 9b623849723ed0eb74b827881c6f32d3434c891b..b4d03e59a8202f20360cff1e2e79b1e325396517 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -578,7 +578,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>   errout:
>  	/* Take a reference in case the DTO handler runs */
>  	svc_xprt_get(&newxprt->sc_xprt);
> -	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
> +	if (!IS_ERR_OR_NULL(newxprt->sc_qp))
>  		ib_destroy_qp(newxprt->sc_qp);
>  	rdma_destroy_id(newxprt->sc_cm_id);
>  	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
> @@ -608,7 +608,7 @@ static void svc_rdma_free(struct svc_xprt *xprt)
>  	might_sleep();
>  
>  	/* This blocks until the Completion Queues are empty */
> -	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
> +	if (!IS_ERR_OR_NULL(rdma->sc_qp))
>  		ib_drain_qp(rdma->sc_qp);
>  	flush_workqueue(svcrdma_wq);
>  
> @@ -619,16 +619,16 @@ static void svc_rdma_free(struct svc_xprt *xprt)
>  	svc_rdma_recv_ctxts_destroy(rdma);
>  
>  	/* Destroy the QP if present (not a listener) */
> -	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
> +	if (!IS_ERR_OR_NULL(rdma->sc_qp))
>  		ib_destroy_qp(rdma->sc_qp);
>  
> -	if (rdma->sc_sq_cq && !IS_ERR(rdma->sc_sq_cq))
> +	if (!IS_ERR_OR_NULL(rdma->sc_sq_cq))
>  		ib_free_cq(rdma->sc_sq_cq);
>  
> -	if (rdma->sc_rq_cq && !IS_ERR(rdma->sc_rq_cq))
> +	if (!IS_ERR_OR_NULL(rdma->sc_rq_cq))
>  		ib_free_cq(rdma->sc_rq_cq);
>  
> -	if (rdma->sc_pd && !IS_ERR(rdma->sc_pd))
> +	if (!IS_ERR_OR_NULL(rdma->sc_pd))
>  		ib_dealloc_pd(rdma->sc_pd);
>  
>  	/* Destroy the CM ID */
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

