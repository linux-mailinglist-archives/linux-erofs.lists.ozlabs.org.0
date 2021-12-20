Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 065AB47AFDF
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Dec 2021 16:21:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JHjwC6h7Hz2ym7
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 02:20:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JHjw34CgYz2xXg
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 02:20:45 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V.FrONY_1640013625; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V.FrONY_1640013625) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 20 Dec 2021 23:20:26 +0800
Date: Mon, 20 Dec 2021 23:20:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: Practical Limit on EROFS lcluster size
Message-ID: <YcCfON0nqioRr2yG@B-P7TQMD6M-0146.local>
References: <CAOSmRzhPk4ykswcUTnK0bj2LdmJ9iwcNuzDpgPQj20d2_rf4Dw@mail.gmail.com>
 <YcCY1tmskGMy+QxV@B-P7TQMD6M-0146.local>
 <YcCbcngdf1jfh0bk@B-P7TQMD6M-0146.local>
 <CAOSmRzgca2U148_3QaTYsPxojY59X49-1tdOCRZZuBvv+sCEvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSmRzgca2U148_3QaTYsPxojY59X49-1tdOCRZZuBvv+sCEvA@mail.gmail.com>
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 20, 2021 at 10:06:33AM -0500, Kelvin Zhang wrote:
> Thanks… Another thing, I’m happy to help writing English documentation for
> EROFS if you have a Chinese version.
>

:) I wrote several Chinese materials many years ago internally, especially
for somewhat complicated compact compressed indexes (which is a reduced
metadata to minimize metadata runtime overhead for better performance,
each lcluster only takes 2-byte metadata on average).

Finally I think we might need a website to document all of this, both in
English and Chinese, including the new container use cases -- Nydus
image service.

I plan to do these after ztailpacking, fscache, folio adaptions are all
finished... (and I'm happy to try any better maintaining approach to
make the overall EROFS solution better/useful for everyone...)

Thanks,
Gao Xiang
