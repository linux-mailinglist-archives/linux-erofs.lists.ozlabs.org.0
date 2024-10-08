Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A657994E13
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 15:12:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNGf25FMhz306d
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 00:12:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728393160;
	cv=none; b=j4Ybxl4NM7vQleCVsunQY1VtiuQ7vpiclCCVJhwoek7bbDlqPjgtiG4LLRU+rfspUOEH5cxgcoW8Dj4SV+nlwCUssFDdAmjjIUQdFaH7Jc4rPhx2sxoM8WfP56glsSBva9KI8B9+V7VoLBMdK/DJGHWckwo/xMqOXlbawJ1d5mDMgWSf06FumRMOrHP2EqHk79h36TV3KNz5yWCM3Whq6oGRM3AulDACE0V4a5ZYCTK5mUiVeJSR0KwunZXCL4bcoM1OpLDEuKiso3eLk3EINInseDYEjiXJ7XLw9j7wnXGQ5HLc7qD1rYU4H5klgp4UGdPDNApErMD8ByBSAIMzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728393160; c=relaxed/relaxed;
	bh=L2tMYa++LilgFGUn5qa+f4HeMfwMqFzOdCyNTGH96cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Su6rvMp5ft74HJOsFrwemKKqPFZIKE6UL73Rd7xkcX4vtGSAt70Ke/bPzJyqhlim4Jv/L43Ak+MdUwZ1GoCfxxSKfPENoMR9W4V6gq/xZz6NIt36IvdpT7YQLxCFJzq1nBqeGcwmpXQa3z94CHUTBhOOJwSpnIA7ahyONM171xDeXpBqNwaAkbFz98t9HzxprY4rpkXGCOR2HqBiYbadMWWuuqDIZGTqe3hr+/8ZGhDUYS1DJF47vrrU71c0fGGmaRNruBhBXc6nfDvea7XFOrZIvjdwzdMj4frUmTlJIle6GjIVyU/XI1FnvxPMQhvRUVW7O8vWtyndLIMPpe3GGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CGeoOUP5; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CGeoOUP5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNGdw0HBRz2xJ6
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Oct 2024 00:12:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728393147; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=L2tMYa++LilgFGUn5qa+f4HeMfwMqFzOdCyNTGH96cU=;
	b=CGeoOUP5xLint5k4POyX+6zuab/0Ex0vKyMIn3aj7tuZQ1L1xJLs0ihlqwoE4CkbiwD75rWbj4vl5dA+4G8Omxu2krhZ98V3eHV1cJMvttHi9+wQOm/+713K/viFkMDXv8t4iroaM+jRfnOPChkL7wvaj6SwZn5xv1kvi+8GJ8o=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGfRSit_1728393144)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 21:12:25 +0800
Message-ID: <9774de2b-2bd6-443e-b502-2c1dd3ccf0a8@linux.alibaba.com>
Date: Tue, 8 Oct 2024 21:12:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
To: Christoph Hellwig <hch@infradead.org>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
 <ZwUcT0qUp2DKOCS3@infradead.org>
 <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
 <ZwUkJEtwIpUA4qMz@infradead.org>
 <ca887ba4-baa6-4d7d-8433-1467f449e1e1@linux.alibaba.com>
 <ZwUr2HthVw9Hc1ke@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZwUr2HthVw9Hc1ke@infradead.org>
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/8 20:55, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 08:33:27PM +0800, Gao Xiang wrote:
>> how about
>> int get_tree_bdev_flags(struct fs_context *fc,
>> 		int (*fill_super)(struct super_block *,
>> 				  struct fs_context *), bool quiet)
>>
>> for now? it can be turned into `int flags` if other needs
>> are shown later (and I don't need to define an enum.)
> 
> I'd pass an unsigned int flags with a clearly spellt out (and
> extensible) flags namespae.

okay, got it.

Thanks,
Gao Xiang
