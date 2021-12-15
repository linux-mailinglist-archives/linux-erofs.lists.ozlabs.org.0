Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB3747609A
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 19:21:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDk946v3kz3bnG
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Dec 2021 05:21:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDk8z4gW9z3bbv
 for <linux-erofs@lists.ozlabs.org>; Thu, 16 Dec 2021 05:21:36 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V-kGr8q_1639592487; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-kGr8q_1639592487) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Dec 2021 02:21:29 +0800
Date: Thu, 16 Dec 2021 02:21:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v6] erofs-utils: lib: add API to iterate dirs in EROFS
Message-ID: <YboyJ1udT7fpz5I7@B-P7TQMD6M-0146.local>
References: <20211215070017.83846-1-hsiangkao@linux.alibaba.com>
 <CAOSmRziwkK7ENwD82jTbOnxk5uKcu4GXP8pb5Rjb6-M5uc=e_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOSmRziwkK7ENwD82jTbOnxk5uKcu4GXP8pb5Rjb6-M5uc=e_w@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 15, 2021 at 09:53:19AM -0800, Kelvin Zhang wrote:
> I don't like the current API design.
> 

Ok, if you don't like the current way, I will convert the author
instead.

Here is my answer why it designs like this:
 
> 1. Input and output to erofs_iterate_dir are mixed in the same struct. It's
> unclear to the caller which members are required input, and which ones will
> be filled out by erofs_iterate_dir. I prefer the old way where input
> parameters are explicitly listed, and the context struct consists of only
> output members.

The problem is there are too many input paramters, and I don't think
they needs to be passed on stack (maybe some by registers, but it
depends) over and over again.

Actually if you looked at some kernel code, there are many such usage:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/pagemap.h#n982
struct readahead_control;

And
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/fs.h#n2023
dir_context, etc.

> 2. When erofs_readdir_cb is called, is the callback allowed to modify
> members inside erofs_dir_context ? If not, the pointer should be marked as
> const, or pass the struct by value. Or explicitly document that any
> modification to the context struct will be ignored.

Ok, actually I'm either fine to add or not add `const'. But I have to
say, erofs-utils is not a C++ project.

But yes, marking const is a good habit. I'm fine to take all of this.

> 3. We are doing dynamic memory allocations inside a loop. Can we just use
> two stack buffers?

I thought before, but I do also care stack overflow (it somewhat happens
on my Mac OS computer.) Dynamic-sized object on stack is tricky, I'd
like to avoid this like what kernel does.

> 4. Many of the current use cases(dump, fsck, android) want to traverse
> directories recursively. Instead of duplicating the work and let each user
> write its own logic to do recursive traversal, provide a sensical default
> implementation that traverses directory recursively? This should be a
> straightforward wrapper around erofs_iterate_dir. For example, adding
> a erofs_iterate_dir_recursive API.

Ok, if you think that saves code, that's fine.

However, fuse don't need to recursively traverse directories. And many
cases don't need to traverse directories in the DFS approach. So, a new
erofs_iterate_dir_recursive API is ok if it really saves code.

Thanks,
Gao Xiang
