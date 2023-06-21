Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A06F737B27
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 08:23:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmD3K3hFJz30hH
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 16:23:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmD3D0Pf6z30D2
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 16:23:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vlet1mQ_1687328608;
Received: from 30.97.48.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vlet1mQ_1687328608)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 14:23:29 +0800
Message-ID: <0195e8d3-a60a-d2ce-3311-a06f670d2ff6@linux.alibaba.com>
Date: Wed, 21 Jun 2023 14:23:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: EROFS: Detecting atomic contexts
To: Sandeep Dhavale <dhavale@google.com>
References: <CAB=BE-SoekaY1oS1wn383DtHngO2BO1-gsUY-STHk9ciKA1OYA@mail.gmail.com>
 <4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.alibaba.com>
 <CAB=BE-QV0PiKFpCOcdEUFxS4wJHsLCcsymAw+nP72Yr3b1WMng@mail.gmail.com>
 <9a8a07de-4364-3d06-4d48-2d51a74e1871@linux.alibaba.com>
 <CAB=BE-S2QpatqeiH=s+xJOV=n0J=W6CBgJY_UUtJ8JYEd7mReg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-S2QpatqeiH=s+xJOV=n0J=W6CBgJY_UUtJ8JYEd7mReg@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/21 14:18, Sandeep Dhavale wrote:
> On Tue, Jun 20, 2023 at 5:38 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

...

>>
> I think this looks good. rcu_read_lock_any_held() can detect this.

Okay, could you submit a formal patch with detailed background in the
commit message (also why this original optimization is important --
because we could reuse dm-verity workqueue to avoid scheduling
another workqueue which is bad for app performance)?

Thanks,
Gao Xiang
