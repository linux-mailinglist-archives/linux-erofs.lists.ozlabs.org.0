Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213B99C4DB4
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 05:19:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnY8r6c58z2yYd
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 15:19:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731385179;
	cv=none; b=Iggr0e9pbqVwKZEjlK+gVG9f6rPOFFjy9nJ9bgQxJkNLlWJIuYkg77Isze4Lg6hHUgr2VomjGOsKT6y2LmPfPxbZ+Y+kZJ4rP+670sjrFUo9e8BBvOtIKC2N8i8bl7DRBuMipXj0/6qurBzT2VUO4dnTvLGZwQF8J1BLp1m/nFiloltxfipu8Gt6wR/mCC7UF8um6gyARdZg/RlA+IPp8WyCbNbbPRm8KMbudouulcdEohR2/Y1c0NWh8UIeewmDpbAEipXUnp+mUWeBiyyee7it3D5Z0gafigknTNJ1r6/RHScGk6XCMN+jRIzdMNvk7H7e3T+OQwIzsHc9jbziMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731385179; c=relaxed/relaxed;
	bh=c7fKyxo/pz++dyvvsWAfAxtkWd5v7tNsGWpTG2MvWsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlOLGTIYo1B3X60JyOetcfA3LIFrsw0qip/tJcTZciFzzGC1XB6EgyGNU/j6XAV1L8cDiA1PTLZerHKpTTBKELlJPCwqlTwPqcW1t6HbmSZaqSDD+yVq0EXDN2aMn9Aucs4ETqfuP05G2UGYO7M+4aiOeDA+h1bd2A34zg2hvnqTsHiHAv7iy/Nq5kTEdPkOSZ105CSL+ZZQ7xPM/D9mGthwzXA0L56vySfzXPOdZBpThuWj5Dwpoz1F1vM6SBKclD2XRjyyescIuGk+PK1WhoitNy0GR/Tn3gOggjQffpssJAEQY+BbH7Mtc0nDYlkRXLKPMKeEXK5+fFjKdelTrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bF4molpr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bF4molpr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnY8l4zsmz2xlF
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 15:19:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731385168; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=c7fKyxo/pz++dyvvsWAfAxtkWd5v7tNsGWpTG2MvWsU=;
	b=bF4molprIYc4koXSfa5yhUS8h1iMNu802He/OjTgT+UiAzQIzSINsYjqY6vADOrhqHHiXCxcnzbvB97BabGGQIhnm3lfk5Y0EA9bbOHj3e1+DMP3boXB6la51lG1xqiF1T1Gbl6G97B1+HDtL5xCpOc+j2yrNBzUy/dvoUFPaAw=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJFcaxu_1731385166 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 12:19:26 +0800
Message-ID: <7c26a52e-2642-41b8-bc1c-990567dd2109@linux.alibaba.com>
Date: Tue, 12 Nov 2024 12:19:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] erofs: free pclusters if no cached folio is attached
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20241112043235.546164-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241112043235.546164-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/11/12 12:32, Chunhai Guo wrote:
> Once a pcluster is fully decompressed and there are no attached cached
> folios, its corresponding `struct z_erofs_pcluster` will be freed. This
> will significantly reduce the frequency of calls to erofs_shrink_scan()
> and the memory allocated for `struct z_erofs_pcluster`.
> 
> The tables below show approximately a 96% reduction in the calls to
> erofs_shrink_scan() and in the memory allocated for `struct
> z_erofs_pcluster` after applying this patch. The results were obtained
> by performing a test to copy a 4.1GB partition on ARM64 Android devices
> running the 6.6 kernel with an 8-core CPU and 12GB of memory.
> 
> 1. The reduction in calls to erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (times) |   11390   |   390    | -96.57% |
> +-----------------+-----------+----------+---------+
> 
> 2. The reduction in memory released by erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (Byte)  | 133612656 | 4434552  | -96.68% |
> +-----------------+-----------+----------+---------+
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
