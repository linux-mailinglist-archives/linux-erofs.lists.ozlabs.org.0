Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B168F514984
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Apr 2022 14:36:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KqX6X2Gq9z3bc1
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Apr 2022 22:36:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KqX6Q01NKz2xrc
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Apr 2022 22:36:27 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0VBi7oKH_1651235776; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VBi7oKH_1651235776) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 29 Apr 2022 20:36:18 +0800
Date: Fri, 29 Apr 2022 20:36:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Xin Yin <yinxin.x@bytedance.com>
Subject: Re: [RFC PATCH 0/1] erofs: change to use asynchronous io for fscache
 readahead
Message-ID: <YmvbwKSdiCosPhAV@B-P7TQMD6M-0146.local>
Mail-Followup-To: Xin Yin <yinxin.x@bytedance.com>,
 jefflexu@linux.alibaba.com, xiang@kernel.org, dhowells@redhat.com,
 linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
 linux-fsdevel@vger.kernel.org, boyu.mt@taobao.com,
 lizefan.x@bytedance.com
References: <20220428233849.321495-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220428233849.321495-1-yinxin.x@bytedance.com>
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
Cc: boyu.mt@taobao.com, dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-cachefs@redhat.com, lizefan.x@bytedance.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xin,

On Fri, Apr 29, 2022 at 07:38:48AM +0800, Xin Yin wrote:
> Hi Jeffle & Xiang
> 
> I have tested your fscache,erofs: fscache-based on-demand read semantics 
> v9 patches sets https://www.spinics.net/lists/linux-fsdevel/msg216178.html.
> For now , it works fine with the nydus image-service. After the image data 
> is fully loaded to local storage, it does have great IO performance gain 
> compared with nydus V5 which is based on fuse.

Yeah, thanks for your interest and efforts. Actually I'm pretty sure you
could observe CPU, bandwidth and latency improvement on the dense deployed
scenarios since our goal is to provide native performance when the data is
ready, as well as image on-demand read, flexible cache data management to
end users.

> 
> For 4K random read , fscache-based erofs can get the same performance with 
> the original local filesystem. But I still saw a performance drop in the 4K 
> sequential read case. And I found the root cause is in erofs_fscache_readahead() 
> we use synchronous IO , which may stall the readahead pipelining.
> 

Yeah, that is a known TODO, in principle, when such part of data is locally
available, it will have the similar performance (bandwidth, latency, CPU
loading) as loop device. But we don't implement asynchronous I/O for now,
since we need to make the functionality work first, so thanks for your
patch addressing this.

> I have tried to change to use asynchronous io during erofs fscache readahead 
> procedure, as what netfs did. Then I saw a great performance gain.
> 
> Here are my test steps and results:
> - generate nydus v6 format image , in which stored a large file for IO test.
> - launch nydus image-service , and  make image data fully loaded to local storage (ext4).
> - run fio with below cmd.
> fio -ioengine=psync -bs=4k -size=5G -direct=0 -thread -rw=read -filename=./test_image  -name="test" -numjobs=1 -iodepth=16 -runtime=60

Yeah, although I can see what you mean (to test buffered I/O), the
argument is still somewhat messy (maybe because we don't support
fscache-based direct I/O for now. That is another TODO but with
low priority.)

> 
> v9 patches: 202654 KB/s
> v9 patches + async readahead patch: 407213 KB/s
> ext4: 439912 KB/s

May I ask if such ext4 image is through a loop device? If not, that is
reasonable. Anyway, it's not a big problem for now, we could optimize
it later since it should be exactly the same finally.

And I will drop a message to Jeffle for further review since we're
closing to another 5-day national holiday.

Thanks again!
Gao Xiang

