Return-Path: <linux-erofs+bounces-1443-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38533C8EE2C
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Nov 2025 15:52:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dHKCV4WRqz2xP9;
	Fri, 28 Nov 2025 01:52:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764255142;
	cv=none; b=WLSYtOZFjczzaR3D6Nsfgq59Kks3hUei2EFfkp49qwUQE52+07CP768uQOLM6t7h0E8qkf/Mj6hFMcTU5MJYVODhn7EpjebVVOSVBCzVlZ4PztLtitV60f+PlAcLUGRZ0spO7tWY2Zp00oAVKztIx+weB0r3HqRWVkWUHtmLW/lFPOk9pNK4T2LCrWeOWGwssDDzJbjJZTCPk9RsEhcKNhuvV3pXhDqb1bSLO4OnturoLucdCn3gf4hfhMl5l5VRbEByKkOhEn7I52MbozfP3PTWHlkYhENk9SOfWp2qgcOsqsmfu2cMrYzArN5rXLzj8/WtHVhUZDMxzA5E9h0urA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764255142; c=relaxed/relaxed;
	bh=sKh8+EAjY0E/BttkllLM+GNwH/C78y3Y8X2jEERKIwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB9Sxpxlx9F9thNgfKvrIJUDcNkKTp98IEjMomzK/0uWnXdCtUItIIPjTdzys5HuW7EquX4BpqF7BbCO/b7AT651E2izb8nCQ+oOnK/QGlqPLRj8FeawZ2qOftKhsWE7CVXMyfL4M+zKc5MdZG4/NT6mViSO6G7wKRB/QJ5WRWh7xtyC0RsVVRnIXfs0WyyCMBUPi2wKO2Fn6sDvaQOyTxkjpgAFXo9+HZNP7Si/jRyGR2pZEIkjj2BOoVD73R54mBI9fcZJm/ip19wXglvxmh9RDcl32Ir6wr2+1WXazFVm1A/ORGIBmnEHw1uWH39WG29Eym0xIFU491Qol1x0nQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+01bc9773882a026547e3+8131+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+01bc9773882a026547e3+8131+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dHKCM2wDQz2xP8
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Nov 2025 01:52:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sKh8+EAjY0E/BttkllLM+GNwH/C78y3Y8X2jEERKIwk=; b=FAMb8ZU/u6dq2L0eJsljkCh0U8
	GSByOFudo38eZSEc/kG5dkcheZPRFGrXZQ0l2pvfvfCnt2M48zXjK0GNjhy0L4UQHNNcK3THeC64D
	XT9RfY371+DF2ZwQLCPaqBDx7waDTMGfwIYi7z1pzmFB73+CGxDH28Hh5hYrIw0npjGy3MQAHa1OW
	E7AhrkFk0bzhilwAAq5nAx8QZNX4WKpU1VAFKFSMac2cPihGOQLhg6y0C7TmUovQ9SPJ1jWb8aZ0f
	uz5C6N61DrZWtkVAoRbwFFmgBhnVZDGVa/vUzO+RN6lYuk4HScNp4xItHvF/i6qS3o7c/T2R5Opj2
	90I0of+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdLq-0000000GoMn-0yOQ;
	Thu, 27 Nov 2025 14:52:06 +0000
Date: Thu, 27 Nov 2025 06:52:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@redhat.com>,
	Stephen Zhang <starzhangzsd@gmail.com>
Subject: Re: [PATCH v2] erofs: get rid of raw bi_end_io() usage
Message-ID: <aShlljdYBidpAjjQ@infradead.org>
References: <20251127080237.2589998-1-hsiangkao@linux.alibaba.com>
 <20251127080756.2602939-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127080756.2602939-1-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Nov 27, 2025 at 04:07:56PM +0800, Gao Xiang wrote:
> These BIOs are actually harmless in practice, as they are all pseudo
> BIOs and do not use advanced features like chaining.  Using the BIO
> interface is a more friendly and unified approach for both bdev and
> and file-backed I/Os.
> 
> Let's use bio_endio() instead.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


