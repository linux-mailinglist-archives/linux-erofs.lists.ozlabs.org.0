Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74FB3D79D4
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 17:30:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZ1353n8rz3081
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jul 2021 01:30:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZ12z2MFbz304j
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jul 2021 01:30:48 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UhAApBh_1627399832; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UhAApBh_1627399832) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 27 Jul 2021 23:30:34 +0800
Date: Tue, 27 Jul 2021 23:30:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re:
Message-ID: <YQAml8DRs4dTWS2n@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Huang Jianan <huangjianan@oppo.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>,
 Andreas Gruenbacher <agruenba@redhat.com>
References: <20210727025956.80684-1-hsiangkao@linux.alibaba.com>
 <20210727151051.GH8572@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210727151051.GH8572@magnolia>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 27, 2021 at 08:10:51AM -0700, Darrick J. Wong wrote:
> I'll change the subject to:
> 
> iomap: support reading inline data from non-zero pos

I'm fine with this too. Many thanks for updating!

Thanks,
Gao Xiang

