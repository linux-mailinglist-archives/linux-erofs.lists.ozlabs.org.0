Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C249960E7
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 09:31:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNl1Y29TDz3bbR
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 18:31:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728459071;
	cv=none; b=a/U95o7emkxGdTh3bke8O0Ob2+VuAlJMlXhyWliDZxDt9C/I7sxHfFwaiRejbBPMc67XCpkiKo6RefIklf838xlcejcoxXMvfJUEBbTrajqTLp9nuC8/Bz8gdbaANJ4AqVpLBnUMZWHF1WohkQp+2hb3bPRiP+NrbW7tRBFXjEJRrhLZMXZI7FHBfhNry9srs7pyjHXoWuhEzTFoZjUVd7MDEvlSZiOUnh0oTEZn/DgAA/2GjgBU7J/nBKmDGriSQGem4Vkx6Nnm0i+il9tCGjqzYU1UcMAQXa6Y84/FsB/aYjvnHn+njwbDly7vL8I6/9KytHkxn1dS/7efJp2iIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728459071; c=relaxed/relaxed;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu8PsoGk4rvcIN7XhoR6eJhLwQ2+7lL4ns1HurHMSnxWqVUxuO1ZXOokP3+4uE/J9uJ89KR8ck0ZMWHd5W50LVw0elw0mP4fqOdQ6bQPYaCRaiOmh3yJdfjGNw+eYn7v4R7wwNLevAxlzaksEg3UEQMCmpl+tU9OxvJQOVZyXBE4N3WtIE42qFd6qV01CB17F0cOuOO4THDk5ZYpKsQQ3NcEsC/QPqz4TiwjiErObC19hnusTUuSG4JA4idYqeHQaQdj7p3PODQTJatuf/+Ft6Gmd/k21++oN+DWvxCLt/OW0nc1jkPDLrr4CQQeKtDTQP0ZnSGwt6CKNKd10FIsAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hVZ9FAdQ; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+cb460f4b002c9a6a9c29+7717+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hVZ9FAdQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+cb460f4b002c9a6a9c29+7717+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNl1N3yKJz2yY1
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Oct 2024 18:31:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hVZ9FAdQQRkUduD36fYPkntV8C
	JGCuDWzI82F5ewjyrpq7AbIYO/WKo3qVktuNb1G765tGITWBhthkUnFLFbYaD85y3kb7igIaFd6O1
	CNl/KiAjKdWTvd5l4jsJQF+UtSkI6P6SDKgAd5TFS+Q3BZd+1jFO09HsDCGT0R98rdoEI/nHgtgXY
	aMNnNLOzMj4u6WyWvfq7pFV7dKzCH7QR2Ln4XwCtLpkE4JCGRf7pJhcMT/dWk9wa0JqT5HcMWFlaR
	c/LUKr1YINz7C9l0B5nEmxWhjnca4rQawNZO0W8GU8yJn3Bvr4fTIny/ojXaoiqCFXPA+jaNUlaJB
	AA/sg2OA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syR9p-00000008F3I-2TA3;
	Wed, 09 Oct 2024 07:30:53 +0000
Date: Wed, 9 Oct 2024 00:30:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Message-ID: <ZwYxLXumaU-CYzj8@infradead.org>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

