Return-Path: <linux-erofs+bounces-818-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AED27B27D94
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Aug 2025 11:55:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3HXT4xnhz3cd1;
	Fri, 15 Aug 2025 19:55:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=81.70.192.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755251705;
	cv=none; b=LZIJEBljXERf2HRkuYRhrbJKfg+NviEpfj8hapiCzXRHzVF+GuU1Yew7bHc36pW4FcGS33JwXbUFCowFCylA3GupIc5I+vh4okTYYVshV+ebV9FD22zYyC5fSMwASJFfqg9vqUZiZPkd5/gjh7NdKZ+ezwa8+9O8xFkKWTAAOjwUAcMV+NpG4LJAcLz6wO7s2UMvGqyI66Y54+O2EV7KAtghUudFl4M4Tb6udh0WRF+TYHKqDbKM8Y0bETYN1pTluhLpQS2DLn5JY8RU+3KdQZD2TmKYZnYDNqERLFaLWiI6cUelXlDz30Ruc/Sld8y1jIx+GEu5jtEtKRfuJgvnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755251705; c=relaxed/relaxed;
	bh=rixGrBynn2pcBX29SfwOC5rR66w5EkxfPX8rJ/+E5kI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBgpjiwdNZfbtSvFGUYxYPfRua0Wy/cDElLB6k4eEHahwnMusnYY+ZxS0dbVoG+3cMo0dUknlUKHO/pE5tvQxvIROJVYgU7jerw/18LttNBs4CRehoB1+yOuYyAqZB0AfXSacMW7DyzKigBPSLSODUKkZ4BS4NpcVLfkC1rfrnpkCtwk1zrg5UwQTmo2icjMhTVhqJgE8kE6Zxa3HO2YrLn0f/U1is5UocRs5194s6UM8/MKehpasjvhiB8vexqXmPyiFAYe70qOjAAR/177tSxP81gQlgPjJHsXsCUSQZzW45eQ3mPWmt0d4ZRbTuR+SfLb1ONqrm6zFwqQZsOdYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=honor.com; dkim=pass (1024-bit key; unprotected) header.d=honor.com header.i=@honor.com header.a=rsa-sha256 header.s=dkim header.b=Xy8HLeHH; dkim-atps=neutral; spf=pass (client-ip=81.70.192.198; helo=mta22.hihonor.com; envelope-from=wangzijie1@honor.com; receiver=lists.ozlabs.org) smtp.mailfrom=honor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=honor.com header.i=@honor.com header.a=rsa-sha256 header.s=dkim header.b=Xy8HLeHH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=honor.com (client-ip=81.70.192.198; helo=mta22.hihonor.com; envelope-from=wangzijie1@honor.com; receiver=lists.ozlabs.org)
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3HXS0Qgfz3ccV
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Aug 2025 19:55:03 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=rixGrBynn2pcBX29SfwOC5rR66w5EkxfPX8rJ/+E5kI=;
	b=Xy8HLeHHGRy0e+DfxoQT9hSYJxxAto0SIjYSb2v++79SO33iXT3kTCASwN0zpbwOCjvUPICvo
	JMGQO7/nFfAB284uDjOTWZPDxSn/hw2ZNJv4OEbtR6ewWGx9D/dgPhbA5nV48aQdHg0PmsJ0u55
	mLujDo1yXhX2E/nUcvulV8o=
Received: from mta20.hihonor.com (unknown [172.31.8.5])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c3HXD4ZhtzYl3bl
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Aug 2025 17:54:52 +0800 (CST)
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c3HX165c6zYmKJ9;
	Fri, 15 Aug 2025 17:54:41 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 17:54:50 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 17:54:49 +0800
From: wangzijie <wangzijie1@honor.com>
To: <hsiangkao@linux.alibaba.com>
CC: <bintian.wang@honor.com>, <feng.han@honor.com>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<stopire@gmail.com>, <wangzijie1@honor.com>, <xiang@kernel.org>,
	<zhaoyifan28@huawei.com>
Subject: Re: [PATCH] erofs-utils: avoid redundant memcpy and sha256() for dedupe
Date: Fri, 15 Aug 2025 17:54:49 +0800
Message-ID: <20250815095449.4163442-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f2c93019-5f92-4ee2-88bc-feda330d8a55@linux.alibaba.com>
References: <f2c93019-5f92-4ee2-88bc-feda330d8a55@linux.alibaba.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.144.23.14]
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a011.hihonor.com
 (10.68.31.243)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


> Hi Zijie,
> 
> On 2025/8/15 16:44, wangzijie wrote:
> > We have already use xxh64() for filtering first for dedupe, when we
> > need to skip the same xxh64 hash, no need to do memcpy and sha256(),
> > relocate the code to avoid it.
> > 
> > Signed-off-by: wangzijie <wangzijie1@honor.com>
> 
> Thanks for the patch, it makes sense to me since we only keep one
> record according to xxh64 (instead of sha256) for now:
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Although I think multi-threaded deduplication is more useful, see:
> https://github.com/erofs/erofs-utils/issues/25
> but I'm not sure if you're interested in it... ;-)

Hi Xiang,
Thank you for providing this information, I want to optimize mkfs time with
dedupe option and send this patch. I will find time to research Yifan's demo
of multi-threaded deduplication and try to provide some help.

> Thanks,
> Gao Xiang



