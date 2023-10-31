Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FAB7DC689
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 07:27:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SKKtY75Z1z3c40
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 17:27:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SKKtQ4HHMz2xwD
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Oct 2023 17:27:08 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VvGHJmL_1698733618;
Received: from 30.221.133.171(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VvGHJmL_1698733618)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 14:27:00 +0800
Message-ID: <59d16fd0-4a9f-b293-18f8-58ed3250ea6c@linux.alibaba.com>
Date: Tue, 31 Oct 2023 14:26:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix erofs_insert_workgroup() lockref usage
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
 <CAHk-=wiDZXndsFtCCebQGCxg+y24WtOEMF0P24W4zPMA6VPiyQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHk-=wiDZXndsFtCCebQGCxg+y24WtOEMF0P24W4zPMA6VPiyQ@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/10/31 14:20, Linus Torvalds wrote:
> On Mon, 30 Oct 2023 at 20:08, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> As Linus pointed out [1], lockref_put_return() is fundamentally
>> designed to be something that can fail.  It behaves as a fastpath-only
>> thing, and the failure case needs to be handled anyway.
>>
>> Actually, since the new pcluster was just allocated without being
>> populated, it won't be accessed by others until it is inserted into
>> XArray, so lockref helpers are actually unneeded here.
>>
>> Let's just set the proper reference count on initializing.
> 
>  From a quick superficial look this looks like the right approach.
> Thanks for the quick response.

Thanks, I will trigger a stress test for this and it will be included
in this pull request...

Thanks,
Gao Xiang

> 
>                Linus
