Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6A0619616
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 13:20:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N3fpd35QKz3cLf
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 23:20:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N3fpV4RH3z3byj
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Nov 2022 23:20:17 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VTxExbC_1667564409;
Received: from 30.221.128.121(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTxExbC_1667564409)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 20:20:11 +0800
Message-ID: <6064150a-7517-c0e1-72bb-e1a8adcfae74@linux.alibaba.com>
Date: Fri, 4 Nov 2022 20:20:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] erofs: switch to prepare_ondemand_read() in fscache
 mode
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org
References: <20221104072637.72375-1-jefflexu@linux.alibaba.com>
 <20221104072637.72375-3-jefflexu@linux.alibaba.com>
 <2e2eceeb11972462bb9161a73c00a9c77f8af8d2.camel@kernel.org>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <2e2eceeb11972462bb9161a73c00a9c77f8af8d2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 11/4/22 7:46 PM, Jeff Layton wrote:
> On Fri, 2022-11-04 at 15:26 +0800, Jingbo Xu wrote:
>> Switch to prepare_ondemand_read() interface and a self-contained request
>> completion to get rid of netfs_io_[request|subrequest].
>>
>> The whole request will still be split into slices (subrequest) according
>> to the cache state of the backing file.  As long as one of the
>> subrequests fails, the whole request will be marked as failed. Besides
>> it will not retry for short read.  Similarly the whole request will fail
>> if that really happens. 
>>
> 
> That's sort of nasty. The kernel can generally give you a short read for
> all sorts of reasons, some of which may have nothing to do with the
> underlying file or filesystem.
> 
> Passing an error back to an application on a short read is probably not
> what you want to do here. The usual thing to do is just to return what
> you can, and let the application redrive the request if it wants.
> 

Yeah, thanks for your comment. We can fix this either in current
patchset or a separate series. As we just discussed on IRC, we will fix
in the following series.



-- 
Thanks,
Jingbo
