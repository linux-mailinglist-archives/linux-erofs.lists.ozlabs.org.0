Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B7E3F74E5
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 14:16:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvlMY2ldjz2yMP
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 22:16:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h5qKEgXn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=h5qKEgXn; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvlMW1BX1z2yJC
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 22:16:39 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4557610FD;
 Wed, 25 Aug 2021 12:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629893794;
 bh=8txebq8fSyFq9pJPKAVpvF0kEw0g630jQsSaz3xAq3o=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=h5qKEgXnotyvqKxZ5Y+Ly3/g6TTwGv7Jfu2XfFir0LNdgR9n1M5+spTMZPoUMvqh0
 VYsBpbGo5wYkD6ueWPHRg1EExHJ/7VRV7WjhGtxO8OYt71YXBR+GzZMBWvJMJfz/HK
 DhRhu2jIA+gQo1i7xEVzl9PzRPPQl55R8B6QnX9nr1+ZtoZLOxnig7ufqm/ElYHYx9
 g9YkUHeEo7VfwH0K1eRkIn+RtbjswXK9GL5h2LWiwjYN1gPzxA4edy9GU0pciSC0y2
 xVaaABRKN/U0ij876m7ZXHAQ2jaGKaGgVKQVJjilLueL0rhKFb5zel+ddhuevUW+rz
 jC0wN+V18BUHg==
Subject: Re: [PATCH] erofs: fix double free of 'copied'
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Liu Bo <bo.liu@linux.alibaba.com>
References: <20210825120757.11034-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <7b9600f5-c968-3d97-af36-382fa6f0df32@kernel.org>
Date: Wed, 25 Aug 2021 20:16:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825120757.11034-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, kernel test robot <lkp@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/8/25 20:07, Gao Xiang wrote:
> Dan reported a new smatch warning [1]
> "fs/erofs/inode.c:210 erofs_read_inode() error: double free of 'copied'"
> 
> Due to new chunk-based format handling logic, the error path can be
> called after kfree(copied).
> 
> Set "copied = NULL" after kfree(copied) to fix this.
> 
> [1] https://lore.kernel.org/r/202108251030.bELQozR7-lkp@intel.com
> Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
