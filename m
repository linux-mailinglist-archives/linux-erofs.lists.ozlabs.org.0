Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1EC6E3943
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:30:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pzszv5NYrz3cMf
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:30:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EgLgn8xv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EgLgn8xv;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pzszr5Z34z3bbZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:30:48 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1C1FE617D2;
	Sun, 16 Apr 2023 14:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BAFC433EF;
	Sun, 16 Apr 2023 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681655446;
	bh=HymfSVdUjO2cDi75EFsyrdzN33/1+ovPPz+N4tqm7n4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EgLgn8xv9+CkGPCavif6UpsE9EEgz+tDbvRXOQ41u2SSX7aLCvaDNWVmWvEugfR3x
	 +4Grz6xqShSMyKFq4qId+KtQBI6OXWP869LicNIEadS/mEkAvF7uRYOWHHYHP4WCnw
	 eS+ywvXr0TFRWbxE5ZGGxghDQKY9h4Hfi7P/HUsirYqMdHnozzfUOYa3POK06ov59m
	 qlcl+jibjDdqRCHbd9Ax5uZYE3iAcLau6GFIkR98pW0bv69ZcKLfghvjNU72SsxSgx
	 yhHP56Zi5gxX1JGGg3i9APYBoF2EVvUh99zqUmqS27/c/EW9lCqlU0+zH+MXl9fSHq
	 fPlWTU0uqCHeg==
Message-ID: <78f01742-a672-7471-ccb3-e38d5047dab9@kernel.org>
Date: Sun, 16 Apr 2023 22:30:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3] erofs: support flattened block device for multi-blob
 images
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, xiang@kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
 jefflexu@linux.alibaba.com
References: <8be37b4c-5a87-1c10-b0e6-99284e6fd4ca@linux.alibaba.com>
 <20230302071751.48425-1-zhujia.zj@bytedance.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230302071751.48425-1-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/3/2 15:17, Jia Zhu wrote:
> In order to support mounting multi-blobs container image as a single
> block device, add flattened block device feature for EROFS.
> 
> In this mode, all meta/data contents will be mapped into one block
> address. User could compose a block device(by nbd/ublk/virtio-blk/
> vhost-user-blk) from multiple sources and mount the block device by
> EROFS directly. It can reduce the number of block devices used, and
> it's also benefits in both VM file passthrough and distributed storage
> scenarios.
> 
> You can test this using the method mentioned by:
> https://github.com/dragonflyoss/image-service/pull/1111
> 1. Compose a (nbd)block device from multi-blobs.
> 2. Mount EROFS on mntdir/.
> 3. Compare the md5sum between source dir and mntdir/.
> 
> Later, we could also use it to refer original tar blobs.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
