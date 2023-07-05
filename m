Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD1747EAD
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 09:55:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwsRG2LyPz30Q0
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 17:55:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwsRC2sJSz301T
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 17:55:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmfoNa4_1688543745;
Received: from 30.97.48.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmfoNa4_1688543745)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 15:55:46 +0800
Message-ID: <afa51f3e-5ac8-86bd-364e-f55706c40470@linux.alibaba.com>
Date: Wed, 5 Jul 2023 15:55:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] erofs: boost negative xattr lookup with bloom
 filter
To: Alexander Larsson <alexl@redhat.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
 <20230705070427.92579-3-jefflexu@linux.alibaba.com>
 <CAL7ro1GuPZE8ek=uvfHEqGFrbbt=NO1=oO8_B-dVBF9go=StSg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1GuPZE8ek=uvfHEqGFrbbt=NO1=oO8_B-dVBF9go=StSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/5 15:44, Alexander Larsson wrote:
> On Wed, Jul 5, 2023 at 9:04 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

...

>> +       if (erofs_sb_has_xattr_filter(sbi)) {
> 
> As I said in my other mail. I would really like this to just always do
> the filter check. It should be safe as older fs:es have zero in place
> here, and doing this allows me to create composefs images with the
> bloom filters that also work with older kernels.

As my previous email, this flag is on-disk compatible which means old
unsupported kernels will just ignore this and go on mounting.

But this flag indicates a new on-disk feature in the image anyway,
users could know if an image uses the new feature rather than seek to
individual inodes.

Does it sound reasonable or some other consideration?

Thanks,
Gao Xiang
