Return-Path: <linux-erofs+bounces-1608-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89056CDE636
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 07:49:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcx7T0DMkz2xcB;
	Fri, 26 Dec 2025 17:49:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766731796;
	cv=none; b=Q74ZgExR+BogaOORrY5I+dYTKJnjisaJTygMmmoAg4kMDW6Fkm/k7vLUkCGSBMIqo5Zp6KiFWb25c4513qqZm8myOa595TpvkG9s1KkViEtTXNsHRtNpvgpbyvSGPfG2/d7h2f3mBspyGSAUXtwcyUDwWACllAoh0CtshHWExOU7SmWVUfPjNcCr8POWbftF7q4m40N3eqpJuwrPBmTudHtsRVBRKsRs62HHDGf+dRg8+IjwO++CJFpMgIESN3p8YX0/p6LySmZR7HueEa0rTswx5u4bUKzTQE+nyJdV8poHJ9hUiv+iSbMoUTrRXrbw58iK02werjo2RUhacVsq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766731796; c=relaxed/relaxed;
	bh=wHmgYE0RIhDSsOUAjvB6a04yeoFf0UhjLWTQn3K5vJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2bHAwGaZQZ8q6S01zMHMZIbsjf2JwogfINvaCGH0A8vVed0k6fepsQHje6exWBrp+ltegUIlizcR+kl6UOQ3TDtBD4+YiK6KNa5dINZ5/YuzdqKLRtamr98x3lu55sxd99OwMFip+rQOiX3QtBq/y+HHJox0IiXyUGvzs2LS+pPXOkTutohCRS+6+pTnSitb9FlNH7W3CJXLFTuMf1i3sCs4ZQNiALoh9CAu8Kxr0xvLkFh4wzJLZXD8+RcrKTw1+rEy0Vf/DeceZxcFsQHnO48fNgYA/Q5jllkOzIqdAJ2+sBpgOSJPKbuo7HJZme6sljPppx6fM9hTYds99kz5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VO8Zba7O; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VO8Zba7O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcx7Q36FLz2x99
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 17:49:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766731786; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wHmgYE0RIhDSsOUAjvB6a04yeoFf0UhjLWTQn3K5vJY=;
	b=VO8Zba7OP2sjlLti83VQ890PGzNT9ETjwMKAP7Alg9CnfIu+ZWDjQWK1M92zdM4O3zavuC9C3h1sXa+dU3gvOClD2fXwvqnU9r0EPoAwboNwdcG77tWzywl77R3nvrX1gFIAdupVTZ4Gi5xl4/kFuLOjtj9MQuMr+PvtclfZ5QA=
Received: from 30.221.133.83(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvgjzZL_1766731782 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Dec 2025 14:49:42 +0800
Message-ID: <6571a348-0e96-4c79-91fc-278dbfb2a54a@linux.alibaba.com>
Date: Fri, 26 Dec 2025 14:49:42 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] erofs-utils: mount: gracefully exit when
 `erofsmount_nbd()` encounts an error
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
 <20251223100452.229684-3-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223100452.229684-3-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 18:04, Yifan Zhao wrote:
> If the main process of `erofsmount_nbd()` encounters an error after the
> nbd device has been successfully set up, it fails to disconnect it
> before exiting, resulting in the subprocess not being cleaned up and
> keeping its connection with NBD device.
> 
> This patch resolves the issue by disconnecting NBD device before exiting
> on error.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
> Note:
> - I believe directly killing the child process is unsafe, as it may leave
> in-flight NBD requests from the kernel unhandled, causing soft lockup.
> - And I believe using nbdpath here is safe, as the child process maintains
> the NBD device connection throughout, preventing concurrent access by other
> actors.

What if the child process is already exited earlier, and the current NBD
device is reused for others?

How about keeping the previous nbdfd for ioctl interfaces instead to
avoid nbd device reuse.

Thanks,
Gao Xiang

> 
>   mount/main.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/mount/main.c b/mount/main.c
> index 2a21979..d2d4815 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -1287,10 +1287,23 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
>   
>   	if (!err) {
>   		err = mount(nbdpath, mountpoint, fstype, flags, options);
> -		if (err < 0)
> +		if (err < 0) {
>   			err = -errno;
> +			if (msg.is_netlink) {
> +				erofs_nbd_nl_disconnect(msg.nbdnum);
> +			} else {
> +				int nbdfd;
> +
> +				nbdfd = open(nbdpath, O_RDWR);
> +				if (nbdfd > 0) {
> +					erofs_nbd_disconnect(nbdfd);
> +					close(nbdfd);
> +				}
> +			}
> +			return err;
> +		}
>   
> -		if (!err && msg.is_netlink) {
> +		if (msg.is_netlink) {
>   			id = erofs_nbd_get_identifier(msg.nbdnum);
>   
>   			err = IS_ERR(id) ? PTR_ERR(id) :


