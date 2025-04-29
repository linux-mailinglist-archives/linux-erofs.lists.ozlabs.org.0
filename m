Return-Path: <linux-erofs+bounces-271-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D1FAA0E0E
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 16:00:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zn2581P33z30Vs;
	Wed, 30 Apr 2025 00:00:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745935211;
	cv=none; b=ho7+JXU4aW81KxZ9i5yiDpWmRlCIEJL0uoPfMpjOlKBwAQBjCeMMfx/kmvkBetzSk8uLwuuNdBKYhhszMqjBmRmDpzlEovvt7Ttl44WPs7ZLPzyg9tBfOJZmIqUcq/b6zhVC9SvYPrkWr5zTwzRc2ulKxQEUjAnLha6H/anlv+CbmqoS82Q6SpISQoNFYW4grhsxR7rjoyJLP2t7psAHnbOl9Uy5Vip5kOS6LnAADD4jgbgvZUV95fQ7bV8fLnk7SwssXbnmpXB62zO3wnGUXnbPb8OrgD7n0jBbSgro3q/EpKLJvHjxE263a4zhI6bRlva0k+I3x99GnPBcfYlukA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745935211; c=relaxed/relaxed;
	bh=nPp3+WApdVyART9j4IhJQHH+BUhU4DS+kthDK8UetJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UJLkB4Lga6c4I9bx98VL/WmjEMiV7/EEwciAPGv3tQHFuNhkiycO90KFO5lgdFIlnJAhIN/EwXSPSDYg3F2wZfwExqT7A/2CVEoBtVk81q8oO8LFR8TGsFq/kgr1KByHGWYDsdMKk/iGN1V7hhdMLPPWkds317pm6ob9mbZuMWFNssCd//gv3aeGsMtArlUiTHWWn/8Vd+HoJZJ7x3MA80rFNHg/0OkrJaRQHevlDVujVS6gJS/OdKAFCm9PHTSWmZKMc3FMlPT5cYuGxc/iDOxPfslvNV/LRYuKeZKgkfO/gCML5Wsb6EteUWjsIzch3fJPC3nA04BuDP9ZETwomQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B88xykhW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=egorenar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B88xykhW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=egorenar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zn2562tjYz30Tm
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Apr 2025 00:00:09 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EUFp006711;
	Tue, 29 Apr 2025 14:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nPp3+WApdVyART9j4IhJQHH+BUhU4D
	S+kthDK8UetJ8=; b=B88xykhWW03ZS06FZHUgcnedWMAqgu4hN+eXIxSNbuRQJi
	bv+kOVtsqdSO+CWcqStL0sRRQn18loShTCLeG1AIu0M4i0k05UL3E9NP8IGmknYt
	yFYtarlz9vwem8GDGSMaZLr/SI5l35GsKyJr9UM8oRqozxhd+YnRQhGoaCjDhM1f
	1zICCe8zBZu+rIJ8+wKk5C4B+KC4czsDept8LkqrrGRKsvHdRLBFXY8EV6a/GU7M
	BncwSatvY4fFAXL32GOHtMUuWbyKz/f/uYeQJqbWmHgIQX8XvhF/5qlKvCegEy/Q
	VXwJFVcvdTDJM9bmH10yfCAjBi6HdAc1aOC4h6Ww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahs9bea1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 14:00:05 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53TDxA97022548;
	Tue, 29 Apr 2025 14:00:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahs9be9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 14:00:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TAkT0x024679;
	Tue, 29 Apr 2025 14:00:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1m37ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 14:00:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TE02DM33292790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 14:00:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC7932004B;
	Tue, 29 Apr 2025 14:00:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9746620040;
	Tue, 29 Apr 2025 14:00:02 +0000 (GMT)
Received: from localhost (unknown [9.152.212.62])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 14:00:02 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: Gao Xiang <xiang@kernel.org>
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v1 1/1] erofs-utils: fix endiannes issue
In-Reply-To: <aBDaGgtXhaCr9p0p@debian>
References: <20250429073052.53681-1-egorenar@linux.ibm.com>
 <aBDaGgtXhaCr9p0p@debian>
Date: Tue, 29 Apr 2025 16:00:02 +0200
Message-ID: <87tt67ukyl.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=6810db65 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=jUFqNg-nAAAA:8 a=i0EeH86SAAAA:8 a=SRrdq9N9AAAA:8
 a=zuzNnEiJ7BCyk0WBLrMA:9 a=-tElvS_Zar9K8zhlwiSp:22
X-Proofpoint-ORIG-GUID: AMzTyyWI1QkdfMUNf4P6ja2UbbZaER4B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEwMiBTYWx0ZWRfX2pfNiFwXHrCp wze/ThzD4qgfD6bdmElXpVO5COKmhKF/25xu94/xGAehYAFERtYoNwcLb1SeonC3KRTtlYPhs+2 m61Uh71glb7pS6HRe3H2FQrJinUdgUfNYNL5M/aM/1+jjnfiooEK+KybYMjGLqqIBoe94v5YiwI
 ak0sP/9rqMJWoAV6EhukT3CV0FB64RVb8dTF+2Mk7frMICuPcNXeH7QsZ61RLiGslJGjYNrjobZ 6l1LdEKaKdXTJIEkKWVesCn40KlQJeW8XBbs59b7nJIsIkLeE9/qG9090J3/ZM/tWP1eOz2serE owLp2xmLwpnIN2eBWfWZviTTtFyaY8BwnGHCfOcw+JaMoqPvkrUQN4xIyguuCqns6Ax4qwXUmNK
 4C8K8qbgIX6JCgwhI/Qq7+fP49NCYalAvyesst/W8PqpEdKU4PmzwanZKAJ8ugjyC079Bnvm
X-Proofpoint-GUID: 73gt3SmmuO1rFVwtMYXu1iQqNP-_ck1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=730 clxscore=1011 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290102
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi,

Gao Xiang <xiang@kernel.org> writes:

> Hi Alexander,
>
> On Tue, Apr 29, 2025 at 09:30:52AM +0200, Alexander Egorenkov wrote:
>> From: Super User <root@a8345034.lnxne.boe>
>
> Thanks for catching this, the "From:" line seems invalid, so
> I change it as "From: Alexander Egorenkov <egorenar@linux.ibm.com>"
>

Thanks!
Argh, sorry for the wrong From field.

>
> I guess it could break MacOS compilation, so I update as below:
>
> From d55344291092b69a2ba6f11dbcda52fa534ac124 Mon Sep 17 00:00:00 2001
> From: Alexander Egorenkov <egorenar@linux.ibm.com>
> Date: Tue, 29 Apr 2025 09:30:52 +0200
> Subject: [PATCH] erofs-utils: fix endiannes issue
>
> Macros __BYTE_ORDER, __LITTLE_ENDIAN and __BIG_ENDIAN are defined in
> user space header 'endian.h'. Not including this header results in
> the condition #if __BYTE_ORDER == __LITTLE_ENDIAN being always true,
> even on BE architectures (e.g. s390x). Due to this bug the compressor
> library was built for LE byte-order on BE arch s390x.
>
> Fixes: bc99c763e3fe ("erofs-utils: switch to effective unaligned access")
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Reviewed-by: Ian Kent <raven@themaw.net>
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  configure.ac         |  1 +
>  include/erofs/defs.h | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 6e1e7a1..88f1cbe 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -194,6 +194,7 @@ AC_ARG_WITH(selinux,
>  AC_CHECK_HEADERS(m4_flatten([
>  	dirent.h
>  	execinfo.h
> +	endian.h
>  	fcntl.h
>  	getopt.h
>  	inttypes.h
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 051a270..21e0f09 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -24,6 +24,21 @@ extern "C"
>  #include <config.h>
>  #endif
>  
> +#ifdef HAVE_ENDIAN_H
> +#include <endian.h>
> +#else
> +/* Use GNU C predefined macros as a fallback */
> +#ifndef __BYTE_ORDER
> +#define __BYTE_ORDER	__BYTE_ORDER__
> +#endif
> +#ifndef __LITTLE_ENDIAN
> +#define __LITTLE_ENDIAN	__ORDER_LITTLE_ENDIAN__
> +#endif
> +#ifndef __BIG_ENDIAN
> +#define __BIG_ENDIAN	__ORDER_BIG_ENDIAN__
> +#endif
> +#endif
> +
>  #ifdef HAVE_LINUX_TYPES_H
>  #include <linux/types.h>
>  #endif
> -- 
> 2.30.2

Thanks!
Regards
Alex

