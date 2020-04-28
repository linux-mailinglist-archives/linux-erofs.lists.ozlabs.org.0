Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D6C1BC105
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Apr 2020 16:19:06 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49BP076qnDzDqNN
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Apr 2020 00:19:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1588083543;
	bh=0zKlqYVnb4HjkHOQ7fVtPQdB0wEHmIh7af+8tEHe7KE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cN8T9XkRs7q/sow+6ocexySNiP7RyGUePE+7uNRvWSceWqlWoGAohYFvy4xaN8xFT
	 bzdbopXlHB8uYjUSvlI3GsF/l+Gdlicc6538UzQwQaWdd3mxRo6lAMSooyDfcGUdsB
	 7P89JEBzaZ/7gfIxoIZA6SDDwfQt2xntm62ufQ1Vjy1vxGqXACsJ6IJW6XkvQSPsb+
	 PvK4ryRn79QffeM32EWr2AMU/cx3wFEoFsYleyx1nWjwawIdJPfxFcO/GcbBloKf6J
	 UUDIAxhuR6wOPd8UbsBj44VpSwDGQyMxeeOFndxeZU+AL6MjcAxHf+MQU81lu0A0Xg
	 yZsS0Qh0qpAOg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=66.163.185.58; helo=sonic313-35.consmr.mail.ne1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=GYtPIC7G; dkim-atps=neutral
Received: from sonic313-35.consmr.mail.ne1.yahoo.com
 (sonic313-35.consmr.mail.ne1.yahoo.com [66.163.185.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49BNk54d9VzDqV8
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Apr 2020 00:06:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1588082802; bh=leyLJqsl1DPwvyskQqABV9Df6q0s8n8/lcamhL+w77o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=GYtPIC7GWYNFq6nGhQvtSUsw+77l+r+yfc7GwFQif66KsVz1t7jmpM9MxTb8B+mDlwCJU/DE7Y9SRnXzp/wqeuAZKi8pvbzNNS/YFQkJEAmBYqltAYy7USq6GS4ur30IRrWx3SVxIhbqlJXturGGPmW+1JYzkYvgfOF5vMG/4jlQuzKYihPZxW1gMF3hZHYd+DwKbOIPx/sPC9a0Xb+06Nt3yG70WJ9CQ6o/Q+iD4jXMmg7xukxhjqfOJBAdRuPCEYChIkfv3AWi341TzLy8D/H4FA68U29l9+KiJlRhtuHhgpR3goBhYloBUGb2DZ3dWqU5Fk8p/ydazgp30jrhjQ==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Apr 2020 14:06:42 +0000
Received: by smtp431.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 7e782058b52218a1f068e45d867aac95; 
 Tue, 28 Apr 2020 14:04:39 +0000 (UTC)
Date: Tue, 28 Apr 2020 22:04:23 +0800
To: Shung Wang <waterbird0806@gmail.com>
Subject: Re: [mkfs.erofs]Do you have plan to support selinux file_context
Message-ID: <20200428140415.GA3785@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAKkk4bLEWNpY+AZ0-mQ9eU9gjwWD8nhi3kCsf01Nh7hZWRsPQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKkk4bLEWNpY+AZ0-mQ9eU9gjwWD8nhi3kCsf01Nh7hZWRsPQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15756 hermes Apache-HttpAsyncClient/4.1.4
 (Java/11.0.6)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: gaoxiang25@huawei.com, miaoxie@huawei.com, linux-erofs@lists.ozlabs.org,
 Li GuiFu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Shung,

On Tue, Apr 28, 2020 at 03:20:45PM +0800, Shung Wang wrote:
> Dear developers,
> Current mkfs.erofs doesn't support read sepolicy from file_context .
> Do you have plan to support that?

Yes, definitely. Actually, that is not a real technical blocking.
For me, partially due to my personal hardware limitation, I'm not able
to fetch/compile/test Android system on my personal computer.

If you are an Android software developer, could you kindly help implement
it (and Android.bp if possible) and send a patch to community? that may
be not a complex stuff in my opinion but would be of great help to all
of us. :)

Thanks a lot!
Gao Xiang

> 
> thanks
> best regards,
> Xiong
