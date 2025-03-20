Return-Path: <linux-erofs+bounces-97-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E45A69F4E
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Mar 2025 06:32:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJDjk598mz2yrb;
	Thu, 20 Mar 2025 16:32:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742448746;
	cv=none; b=H06vD/PJqkN+N1rPDPA8yB88d8uMtFigzki7V1FM1qWJlS2Tt82PEjzfS1JZE6ajQf04gGZf3iwqJ4MHpGoFtDz9xYMtk8RDn7ClV/VekYO2bMmzBqSwKBQ4nqtDSLxyVvgFgg2RcxV0UOm1ZFX+EOiDhYejHmy0qR55Z6y4dwvL3QBF9qAJnNbnMz/Eom8/N37k5r8FPZel31/K75ESFcfGhEX8HswKw9ez1/ulMUNm19Q7mE+mw6YOYeh33lwkPRNHU1a71JxNl2f6oAKcGmKtcBlAsdtfV2JC2jUP/V9wU+D37qv3q7kXwmz3PASF9ZnCi1v9b8k7XjjM6xljiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742448746; c=relaxed/relaxed;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmS59fJTrEqoPJtWeJf+zwudVdS4oXcSSF7T+vbMiEnTPic59nkvbx2xXD4L2OJytn8UlgU1WflvHk7WKYNt+e/XovyNzBTjzM+515Ly9P2g9JQVRxtcrYjLBtPiZ4LMaU5lvkpV3Mgu3UttRXPUCZdH7pJ5zJaqilDufJmdkZJGDgkxwg1R7xSC4yLD758oZBl3fT+Sx04JqO0UYGx+DNEWQn4nlpjtdpclm2VaIYQMZPH0XfuNPVFNbzA3c4y+4vdLhvSGJ7l6eemJx42XgF8XChw7LI36DJJn2XdejUwrlAkCxHOwDknvA8l7M0Xf9Oh432rjcKhVAq+ZQfB5cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJDjj2SSnz2yrS
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Mar 2025 16:32:24 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7184568AA6; Thu, 20 Mar 2025 06:32:18 +0100 (CET)
Date: Thu, 20 Mar 2025 06:32:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Brian Foster <bfoster@redhat.com>, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] iomap: fix inline data on buffered read
Message-ID: <20250320053218.GA12640@lst.de>
References: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


