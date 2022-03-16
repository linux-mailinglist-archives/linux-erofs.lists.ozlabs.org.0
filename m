Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F9E4DA8E4
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 04:29:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJG3T1Q1nz30C2
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 14:29:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p8UCyAH3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=p8UCyAH3; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJG3J5VDZz3015
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 14:29:16 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CB01BB81883;
 Wed, 16 Mar 2022 03:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CB8C340E8;
 Wed, 16 Mar 2022 03:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647401348;
 bh=aIceSeELNkeFGeC2kSc1k8qFifJ8gVB3BT8bdETjyG0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=p8UCyAH3H6HpPCCfMoenlagaKEaxQ4xINiKDt7oXB0DqySoEvAONKee1o1nW6t9KT
 +KD/Fxc3c1Ykl9T4zijh0Zaooi4pmboBXFeH8mYS1emOhwjHJTxf39n7rnkkgnJpk9
 vobAjtTA4G+EOUSkHkrBcethWMAAYiYEnN+HsJFmhOxSgrWMrzYhaRbUohyOMv331W
 RTmMV5h6ViAP6mTSwfTpFBlKuGIBWFeOdjmQM14bA2VVQGypUmrxjW+siaKS/wJsnG
 ZZLRk2+ykXj2Mt9YpzUhAxjkRpBA/zUpAHxhJuiBJao+rV+UKB89hpYv6owsTtA6Qi
 5OvexvwoCmzQA==
Message-ID: <fd70cca5-f6cc-9544-9c30-3bed764154a0@kernel.org>
Date: Wed, 16 Mar 2022 11:29:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] erofs: support inode lookup with metabuf
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220316012246.95131-1-hsiangkao@linux.alibaba.com>
 <20220316012246.95131-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220316012246.95131-2-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/3/16 9:22, Gao Xiang wrote:
> This converts the remaining inode lookup part by using metabuf in a
> straight-forward way. Except that it doesn't use kmap_atomic()
> anymore since we now have to maintain two metabuf together.
> 
> After this patch, all uncompressed paths are handled with metabuf
> instead of page structure.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
