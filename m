Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EB39541BA
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 08:32:23 +0200 (CEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="::1"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OOp0L2b3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WlXGY6XfDz2ypx
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 16:32:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OOp0L2b3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WlXGV63Hlz2ygG
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2024 16:32:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723789935; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2stjO2D2LggMeUEIeWcrkNTVh07nDYEoZqLnizcEE/o=;
	b=OOp0L2b3ioSEHuZQXLEEWhe1W9+HMry9uPwMPR/jRAxuzawfwhtRSCO6YVgL6Z9bOjTgfV1wI4MzEeFddtNxwpNlCEc5fN0+GX5mtd8aGB8sAZJQHz/g/VinOFafqKi8rntlQOJoU/BEXgvBooh1JgMcYZgeJmpMRqnniowJhz4=
Received: from 30.221.129.229(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCzVIUc_1723789932)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 14:32:13 +0800
Message-ID: <486ca95a-eb63-441d-8143-da6b099d3a3a@linux.alibaba.com>
Date: Fri, 16 Aug 2024 14:32:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs-utils: adjust volume label maximum length to the
 kernel implementation
To: Naoto Yamaguchi <wata2ki@gmail.com>, linux-erofs@lists.ozlabs.org
References: <61d8a190-3520-4d5d-8c80-adeb7172a88f@linux.alibaba.com>
 <20240816031601.45848-1-naoto.yamaguchi@aisin.co.jp>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240816031601.45848-1-naoto.yamaguchi@aisin.co.jp>
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
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/16 11:13, Naoto Yamaguchi wrote:
> The erofs implementation of kernel has limitation of the volume label length.
> The volume label data size of super block is 16 bytes.
> The kernel implementation requires to null terminate inside a that 16 bytes.
> 
> Logs:
>    $ ./mkfs/mkfs.erofs test16.erofs -L 0123456789abcdef test/
>    $ mount -o loop ./test16.erofs ./mnt/
>    $ dmesg
>    [26477.019283] erofs: (device loop0): erofs_read_superblock: bad volume name without NIL terminator
> 
>    $ ./mkfs/mkfs.erofs test15.erofs -L 0123456789abcde test/
>    $ mount -o loop ./test15.erofs ./mnt/
>    $ dmesg
>    [26500.516871] erofs: (device loop0): mounted with root inode @ nid 36.
> 
> This patch adjusts volume label maximum length to the kernel implementation.
> 
> Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>

Thanks, applied.

Thanks,
Gao Xiang
