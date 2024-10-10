Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0AB998559
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 13:50:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPSkC0vglz3bjs
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 22:50:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728561025;
	cv=none; b=gZ2oYs9s5+QNfxId/owTJ2roFxrFHd9AeBEyAA5n1/gmE0ug19U3izl3+wz400mXRXDYG4jzeg+46BNdg3WfVrFFyIovAkqBkMAU+HAiJ8nDNDJTx6xAMhVT31fHwP6G7AP7XJv9mmiu0lyzV4Ub4rFLMlR6kBLMOBjgZ79+kEsOd5xlGXptmVFS1nKWtPLQ1XzHBkyeLBUQESoW+ldvUe191d2mTDqXVVT4JEYBLXlDdFVSKt1bmIelJqt3uOdQJGl7ufOOP80ZPk33LO1AWcW8o7v6KuMQwVO+y5lAmDNWnWO5YVamVmtx9wfV0BVqXVtO3OZSUdBLCblST45v/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728561025; c=relaxed/relaxed;
	bh=2+3RR5WnYz0+qmi951WdPt6bVMEftrbsCw69V89Je+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q2snl80fsohqcmUqcGfKrylqDqUrfSjeeZl3umQ2JsEISlWxRVB4khxuen8ruGc3MrQdieovGxDej5yU1YFaVCEuMKrY+261z8b8a3jDTE8MrPLc4+lUsNoY8+76hfZhN53u4qOQQsUjlAFgAcj1Lyw4nC0htICjTWsAeHbkJtxs4w1EYNkyQflzaaEj35ub20Vp/z2rH8tVPNyovRjs6G2QeconuItxDhCqB+RTMJFvt+RYuPWLRP5A5nEkS/b2P+uI4NqrpuH9lltJUC1D95OiGIFuEuEFiHxzBQIMyTC2u46lf9YbqY/GUyhNNLK0tRXxgeTwAAV9SZY1MG/gfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VPI106CO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VPI106CO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPSk63ls8z2xjh
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 22:50:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728561012; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2+3RR5WnYz0+qmi951WdPt6bVMEftrbsCw69V89Je+Q=;
	b=VPI106COX9xbFNZfuqhATcNINZEQWSjzHXi1+6Pidr7BmG4g1EF5ZLCxtTU3kOdvMkgVY9mQccn8f7w2lYsjAli9r7JR8GY0K4GV89LPKRNan2gTE8kGJSGt7a3x/cExDnpSk9AcAPL0qhznTGwxd4/znBrvN18/9mQjiLZCyxk=
Received: from 30.221.68.142(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WGmCPPy_1728560998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 19:50:11 +0800
Message-ID: <92e8b0c1-1922-49e7-9633-afbb4d132eea@linux.alibaba.com>
Date: Thu, 10 Oct 2024 19:49:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: tests: fix compression algorithms check
To: linux-erofs@lists.ozlabs.org
References: <20241010095124.2529867-1-hongzhen@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <20241010095124.2529867-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/10/10 17:51, Hongzhen Luo wrote:
> When checking with _require_erofs_compression(), the error "xxx is
> not a block device" occurs. This patch adds "-o loop" to address this
> issue.
>
> Fixes: ace04f5bbc5c ("erofs-utils: tests: add compression algorithms
> check for tests")
>
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   tests/common/rc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/common/rc b/tests/common/rc
> index b739089..4fb4674 100644
> --- a/tests/common/rc
> +++ b/tests/common/rc
> @@ -157,7 +157,7 @@ _require_erofs_compression()
>   	truncate -s 1m $random_dir/test/file > /dev/null 2>&1
>   
>   	eval "$MKFS_EROFS_PROG $opt $random_dir/tmp.erofs $random_dir/test" >> /dev/null 2>&1
> -	_try_mount $random_dir/tmp.erofs $random_dir/mnt || \
> +	_try_mount -o loop $random_dir/tmp.erofs $random_dir/mnt || \
>   		_notrun "fail to mount filesystem in _require_erofs_compression"
>   	_do_unmount $random_dir/mnt
>   

It appears that this fix is not universal (at least for erofsfuse), so 
please disregard this patch.

===

Thansks,

Hongzhen Luo


