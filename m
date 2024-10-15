Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 952D399E432
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 12:39:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSVvh6WyZz3bpP
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 21:39:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728988750;
	cv=none; b=EkqeDSnc2FVHjU31onuwzx+SoOT7gkkY8pQP+Ish98RW4wQMx8gFSx+B5SdwvBtKxtkZ6xBLMaSSkWl5EI7CWcGgP7m99g86j06N6Pff5hmamDsNn7LtGvT5iHMhOXcze4gqqoHUIcNi0EMZmgfoJYVSeaWN4MsVpOk91zLKZ869Pc+DtMHXRD/EHimCExlMn0nymsIxXym3caqfQayUtckB1KB6PKMlBbZDkxmagMmYv/i/gTBKY6yiwn5IxuS+64gpJAwhwIQU5aMX5FSRJp7qbPaAO5vvzX4BP+xHIDdUnkRQT8BQ3p6P2qzouC2Xoa71u/dTAMFbpGOQjdCdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728988750; c=relaxed/relaxed;
	bh=v+dwRPCTeAm3f9Cj5qx8sZFX+iLjtJLr7D++fvDIKQk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CootI+fk2ZiqHUPGPQpeDEqd7TC3bdDuIorXLWX66eIB51OEQLj6B6HMA+ACd44AJmfoV/ragoV8yxsgh4l4SqjvpeMWCeTHsiurGG7Dk5GFugsdD5Q3OX/krGxfS0CKC3WPEQpjHw0Z54PtCVtksCSetBXSYrsOVlAsn5bw3XaIjnGIwUxxB7oYsFJggUzjP83LCfqnTl+meo6E/Ul5TJ3Qwt7jK1g6lEPSGc+vQtDFR4dQhWbs65eMzTmpz+GlKCdmFSWBlA6BL4SmHmc6B1jJ3tLUxpg51OzZLt0mXmOkhYIQvYBRIZJCnNu7Pqz+WQSfuuWWqggDZsaMc5Ftbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IxAhr+1Y; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IxAhr+1Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSVvd4nsnz3bkf
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 21:39:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728988744; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=v+dwRPCTeAm3f9Cj5qx8sZFX+iLjtJLr7D++fvDIKQk=;
	b=IxAhr+1YHE6bz8sED4xf/WFdHBcOjsSeNYFm4ZXik2Gtm7WwVXK8DjjNakRu/EqqN2XW2kHomLcO5j6jRLQipFVYjogNpZ/c7O6zZ3OUElHBn8s6oP1qVWCbXUszs7D9mAN5o8M/VzxhSFvD+xQt9sGwQscbjqvIWYQoeNyLlc8=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHDPpua_1728988742 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 18:39:03 +0800
Message-ID: <62f54645-53cc-46d3-aaab-8583ed7f1a68@linux.alibaba.com>
Date: Tue, 15 Oct 2024 18:39:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>,
 brauner@kernel.org, chao@kernel.org, dhavale@google.com, djwong@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <670e2fe1.050a0220.d5849.0004.GAE@google.com>
 <5f85c28d-5d06-4639-9453-41c38854173e@linux.alibaba.com>
In-Reply-To: <5f85c28d-5d06-4639-9453-41c38854173e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 2024/10/15 17:10, Gao Xiang wrote:
> Hi,
> 
> On 2024/10/15 17:03, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    d61a00525464 Add linux-next specific files for 20241011
>> git tree:       linux-next

..

>>
>> commit 56bd565ea59192bbc7d5bbcea155e861a20393f4
>> Author: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Date:   Thu Oct 10 09:04:20 2024 +0000
>>
>>      erofs: get rid of kaddr in `struct z_erofs_maprecorder`
> 
> I will look into that, but it seems it's just a trivial cleanup,
> not quite sure what happens here...

It seems that it's only caused by an outdated version in
next-20241011, which doesn't impact to upstream or the
latest -next:
https://lore.kernel.org/r/670e399e.050a0220.d9b66.014e.GAE@google.com
https://lore.kernel.org/r/670e3f3f.050a0220.f16b.000b.GAE@google.com

so

#syz set subsystems: erofs

#syz invalid
