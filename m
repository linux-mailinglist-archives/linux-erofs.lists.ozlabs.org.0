Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969016B3684
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 07:21:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXwtK3CD0z3f55
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 17:21:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXwsp3t0Xz3cht
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 17:21:01 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VdWCdER_1678429253;
Received: from 30.97.48.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdWCdER_1678429253)
          by smtp.aliyun-inc.com;
          Fri, 10 Mar 2023 14:20:55 +0800
Message-ID: <bbd8c221-d4d2-8bbf-944f-2f33ed80f02f@linux.alibaba.com>
Date: Fri, 10 Mar 2023 14:20:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/5] erofs: convert to use i_blockmask()
To: Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
 mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org
References: <e8054874-88d8-e539-8fd4-6123821aa3a8@linux.alibaba.com>
 <20230310061549.11254-1-frank.li@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230310061549.11254-1-frank.li@vivo.com>
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
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/3/10 14:15, Yangtao Li wrote:
> Hi Gao Xiang,
> 
>> Please help drop this one since we'd like to use it until i_blockmask() lands to upstream.
> 
> I'm OK. Not sure if I need to resend v5?

Thanks, your patch looks fine to me.  The main reasons are that
  1) active cross tree development on cleanup stuffs;
  2) we'd like to add subpage block support for the next cycle,
     and they seem somewhat convolved...

So I will apply your patch when i_blockmask() is landed upstream
then.

Thanks,
Gao Xiang

> 
> Thx,
> Yangtao
