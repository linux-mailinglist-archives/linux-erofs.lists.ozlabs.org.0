Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EAC737625
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jun 2023 22:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1687293559;
	bh=rz6oa6ahafX/pPa7OiEds/mLQteUGm5ZP+KNTyYoMUQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ioow117vqTum0DO5Xg4VGDOySJUfi2K9ZpfOctl+Ro+Hv65vpay6YsSiPBZpo5MZ5
	 6hxZt5r8pm6T3IkfOvNqaexXIYmmExNR1eDj/PlgE+UNvm/e3e/YqaYgYdjD9ZwCHf
	 LxoNbIjvH2+lCDTdyJGEM/RH1KG4OJwNyD3eevXa8zl0/YGGHvwf/pQa6of58oupsc
	 miz1IEi1eBN202KmK+Pz75GQcfgAeyKNMXZZ49wp6nFDN+izIx2jNI44462Wbm2nC0
	 8FflAbCgNOAEj2/99l5zuAq2d5pVJomamywcKXW3orOAmoWUFlB3x+S/Rb0d6SiSNW
	 l+Tn0/5y7/qqQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qlz534lRsz3bNv
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 06:39:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=JydaG+9J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qlz4w3W7Kz2xBV
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 06:39:11 +1000 (AEST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so5843398f8f.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jun 2023 13:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687293545; x=1689885545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rz6oa6ahafX/pPa7OiEds/mLQteUGm5ZP+KNTyYoMUQ=;
        b=jtTYzejPlmJbTf/Vt/poDhymrx0RfHyuy9WpfOsxH2PjCww2TOMjvhfXQXaWN7AN4X
         FfiZYJbjLQ8CHnFtN6QIEs1VDuerNt4f2poxwBfLnddfZxP9dc2eEIOTLSBU3quYPmKK
         2Fiwe/eFbdCcJBacss9Rqp0oXuthmy+bGxxjcSuDqR+et3VlCn+mz8I+Y4Tyakhab8VE
         O6ekPo70UCY/bMQ+kv9g2IyIJe2/Pb/k2NFZ+QjZnsU0vsA+2Yy9uZ7IcwjEE/X694Fg
         S0K8Gd9QEHGC2hlmZoCbzwSqnoLWCHIkedfw9n95rS75jOYos/lddKqVAgO4Oa80Zg8q
         inIg==
X-Gm-Message-State: AC+VfDyGejgrMVGEBfUybk9j7MAIop/89CLH5kowSpkHC1ojoY/GVD2d
	aG+ob7yfyInKeA1zohjGKHfO2oTxRsazDxKA2o8j3g==
X-Google-Smtp-Source: ACHHUZ4ov8+oMpRav9cucRxtqFncASR9+x0MaBgy/W8RNkXQfEnv7Pq7XO7IJiv92KcMFVl7bDQ/Z9WAhp/F7iMuWt8=
X-Received: by 2002:adf:f58f:0:b0:307:82e3:70cd with SMTP id
 f15-20020adff58f000000b0030782e370cdmr12461638wro.14.1687293544998; Tue, 20
 Jun 2023 13:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=BE-SoekaY1oS1wn383DtHngO2BO1-gsUY-STHk9ciKA1OYA@mail.gmail.com>
 <4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.alibaba.com>
In-Reply-To: <4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.alibaba.com>
Date: Tue, 20 Jun 2023 13:38:53 -0700
Message-ID: <CAB=BE-QV0PiKFpCOcdEUFxS4wJHsLCcsymAw+nP72Yr3b1WMng@mail.gmail.com>
Subject: Re: EROFS: Detecting atomic contexts
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,
I think we are under RCU read lock in the stack at
blk_mq_flush_plug_list+0x2b0/0x354

blk_mq_flush_plug_list calls blk_mq_run_dispatch_ops
which is a macro in block/blk-mq.h

/* run the code block in @dispatch_ops with rcu/srcu read lock held */
#define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
do {                                                            \
        if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {          \
                struct blk_mq_tag_set *__tag_set = (q)->tag_set; \
                int srcu_idx;                                   \
                                                                \
                might_sleep_if(check_sleep);                    \
                srcu_idx = srcu_read_lock(__tag_set->srcu);     \
                (dispatch_ops);                                 \
                srcu_read_unlock(__tag_set->srcu, srcu_idx);    \
        } else {                                                \
                rcu_read_lock();                                \
                (dispatch_ops);                                 \
                rcu_read_unlock();                              \
        }                                                       \
} while (0)

#define blk_mq_run_dispatch_ops(q, dispatch_ops)                \
        __blk_mq_run_dispatch_ops(q, true, dispatch_ops)        \

As you can see if BLK_MQ_F_BLOCKING is not set then dispatch_ops is
called with rcu_read_lock().

rcu_read_lock()
        __rcu_read_lock()
                rcu_preempt_read_enter()

In rcu_preempt_read_enter() increments the rcu_read_lock_nesting which
is detected later during mutex_lock() as a warning.

Regarding use of !in_task(), that cannot detect rcu_read_lock_nesting
as far as I can tell so that may not be sufficient.

Thanks,
Sandeep.
