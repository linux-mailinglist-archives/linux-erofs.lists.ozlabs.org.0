Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB20471204
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 06:45:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9xYw4GWzz3cHW
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 16:45:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9xYm307Sz2xXd
 for <linux-erofs@lists.ozlabs.org>; Sat, 11 Dec 2021 16:44:54 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R461e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V-DNfxn_1639201487; 
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V-DNfxn_1639201487) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 11 Dec 2021 13:44:48 +0800
Message-ID: <a95618c5-723d-bfaa-bf7a-48950be8d31d@linux.alibaba.com>
Date: Sat, 11 Dec 2021 13:44:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [Linux-cachefs] [RFC 09/19] netfs: refactor netfs_rreq_unlock()
Content-Language: en-US
From: JeffleXu <jefflexu@linux.alibaba.com>
To: David Howells <dhowells@redhat.com>
References: <20211210073619.21667-10-jefflexu@linux.alibaba.com>
 <20211210073619.21667-1-jefflexu@linux.alibaba.com>
 <292572.1639150908@warthog.procyon.org.uk>
 <fba8a28b-14c1-bf58-0578-32415c95f55d@linux.alibaba.com>
In-Reply-To: <fba8a28b-14c1-bf58-0578-32415c95f55d@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org, eguan@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 12/11/21 1:23 PM, JeffleXu wrote:
> 
> 
> On 12/10/21 11:41 PM, David Howells wrote:
>> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>> In demand-read case, the input folio of netfs API is may not the page
>>
>> "is may not the page"?  I think you're missing a verb (and you have too many
>> auxiliary verbs;-)
>>
> 
> Sorry for my poor English... What I want to express is that
> 
> "In demand-read case, the input folio of netfs API may not be the page
> cache inside the address space of the netfs file."
> 

By the way, can we change the current address_space based netfs API to
folio-based, which shall be more general? That is, the current
implementation of netfs API uses (address_space, page_offset, len) tuple
to describe the destination where the read data shall be store into.
While in the demand-read case, the input folio may not be the page
cache, and thus there's no address_space attached with it.

-- 
Thanks,
Jeffle
