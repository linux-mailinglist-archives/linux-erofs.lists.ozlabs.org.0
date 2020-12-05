Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C70F2CFACA
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 10:22:42 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp3y72FlHzDqbk
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 20:22:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607160159;
	bh=CU7NnqoJRd+N/KVXifbnNHmUdIf0VXvWAbGLLuQjLRY=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=KM8NUDGrQmFUOmhqgoxiQY70E/Df0kT1c1JgT4NKuasjc9M2u0UZRGsRyslC90I6F
	 eBVpwynDJ5m3E4R+9wDvxFHeGTZIczH3RCAenBFiDiKlODHsUCySWFS3m9Fku5zN1U
	 Ecge+/MamfoRWvG/8TK/J5T824m7b8wF0pmax+dSWGq7aExPjc9+60CImW51nqAizZ
	 47hqiPAHrwmBpfcd4vFLXBPd2FEBiTavyzrsxrYv2Oh9+IphWpkIy7BUB2KhBML+FK
	 lqOywAnmBgwqXrN9/CluyljcbS8937JD8HMrdKUlg7K1Wr7Iebu8T5ExtlRxP3EyvF
	 vElN8U0k2gMbA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.40;
 helo=out30-40.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=CTxeXlNV; dkim-atps=neutral
Received: from out30-40.freemail.mail.aliyun.com
 (out30-40.freemail.mail.aliyun.com [115.124.30.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp3y01BGjzDqbk
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 20:22:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1607160134; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=IfD+AlARZpSJzowwii6FUTcK74QfBD8+ht3Gv8t9CMY=;
 b=CTxeXlNVuYgT3TUI58GShPCGjck+IyFlYbPKdjtWeOSHLM67Bdo8KjAE0K5YzXJCuzq7rzcWLJggkFIxwIOpVmG2MEJQSvcQAjIsZJbJ83aN21k7WQOR1fXQv6hztxHlWkj/rsB6VsjZsIU5Wat5r5VzBxnhyPlD44lummB+WaE=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1166466|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0103292-0.000809459-0.988861;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04420; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UHa2-Ax_1607160133; 
Received: from 172.168.2.18(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UHa2-Ax_1607160133) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 05 Dec 2020 17:22:14 +0800
Subject: Re: [PATCH v2] erofs-utils: update i_nlink stat for directories
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201205091637.8944-1-hsiangkao.ref@aol.com>
 <20201205091637.8944-1-hsiangkao@aol.com>
Message-ID: <a289b333-c1ef-02f2-9897-c69061053409@aliyun.com>
Date: Sat, 5 Dec 2020 17:22:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201205091637.8944-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2020/12/5 17:16, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> Previously, nlink of directories was treated as 1 for simplicity.
> 
> Since st_nlink for dirs is actually not well defined, nlink=1 seems
> to pacify `find' (even without -noleaf option) and other utilities.
> AFAICT, isofs, romfs and cramfs always set it to 1, Overlayfs sets
> it to 1 conditionally, btrfs[1], ceph[2] and FUSE client historically
> set it to 1.
> 
> The convention under unix is that it's # of subdirs including "."
> and "..". This patch tries to follow such convention if possible to
> optimize `find' performance since it's not quite hard for local fs.
> 
> [1] https://lore.kernel.org/r/20100124003336.GP23006@think
> [2] https://lore.kernel.org/r/20180521092729.17470-1-lhenriques@suse.com
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> v1: https://lore.kernel.org/r/20201205055732.14276-1-hsiangkao@aol.com
> changes since v1:
>  - update a DBG_BUGON statement suggestted by Guifu.
> 
>  lib/inode.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
