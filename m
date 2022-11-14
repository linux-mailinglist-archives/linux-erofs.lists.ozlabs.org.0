Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D8627D6E
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Nov 2022 13:12:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N9p8T5njmz3dvD
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Nov 2022 23:12:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.15; helo=out199-15.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N9p854WLmz3cNG
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Nov 2022 23:11:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VUmziyc_1668427899;
Received: from 30.221.128.223(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VUmziyc_1668427899)
          by smtp.aliyun-inc.com;
          Mon, 14 Nov 2022 20:11:40 +0800
Message-ID: <55b07140-f7b9-6c25-acf0-93e9fbce0828@linux.alibaba.com>
Date: Mon, 14 Nov 2022 20:11:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] erofs: fix missing xas_retry() in fscache mode
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20221111090813.72068-1-jefflexu@linux.alibaba.com>
 <575542.1668426273@warthog.procyon.org.uk>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <575542.1668426273@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

Thanks for the comment.

On 11/14/22 7:44 PM, David Howells wrote:
> Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> The xarray iteration only holds RCU
> 
> I would say "the RCU read lock".

Yeah, this looks clearer. I will update the commit message in v2 later.

> 
> Also, I think you've copied the code to which my dodgy-maths fix applies:
> 
> 	https://lore.kernel.org/linux-fsdevel/166757988611.950645.7626959069846893164.stgit@warthog.procyon.org.uk/
> 

Thanks for the kindly reminder. Yeah this code was ever copied from
libnetfs. In the scenario of erofs, currently req->start is always
aligned with folio size and erofs doesn't support large folio yet. Thus
req->start won't be inside the folio so far, and I think the current
code works well in the scenario of erofs, though the issue indeed exist
mathematically.

Actually I'm working on the support for large folio now, and the
completion routine of erofs in fscache mode will be refactored quite a
lot. I think this issue will be fixed along with the refactoring.

Thanks again for the suggestion :)

-- 
Thanks,
Jingbo
