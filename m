Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AF82E0B9C
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 15:22:50 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0dpb2WXwzDqJt
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Dec 2020 01:22:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+9b673c29b2be71bbe139+6330+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0dpR6wlfzDqJ8
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Dec 2020 01:22:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hYnCL/Z0LMH7jTIypqvf/4LgCsg5+aYOBvlIsw/Dfzw=; b=bTEPE34SwYAvu29kn68FrqY2Z9
 3bL5mRxgSbYTbn2ehqbWCaCkz8xpwvyemI7mAp9vkYjTlQKdUVZWt3dLxJux15wGFqaSw5Puqkry+
 Aacl9zQjB/ijChJnjG4qlOMfPXaz6O3EPABOPzWAHwGUMZtCqJgZ8JTdeOQL3XyVJ0lUywAA5FP56
 vmCOzy05UHogeP6c28ICR1s6V80oGPmLh7g4d2rEAfEjVqiZyvSPLoxJDYwEoaGXrFXNrgtZk+nnO
 ThMoPmsIDGWzNCWhI9HdZdiwOovBhX2/B65VWgyRufCAhTIPpOmxJfTb2JjNniuSFSZyvh9gT/mc/
 mkRC4lUg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kriYc-0004qi-8T; Tue, 22 Dec 2020 14:22:34 +0000
Date: Tue, 22 Dec 2020 14:22:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201222142234.GB17056@infradead.org>
References: <20201214140428.44944-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214140428.44944-1-huangjianan@oppo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Please do not add new callers of __blockdev_direct_IO and use the modern
iomap variant instead.
