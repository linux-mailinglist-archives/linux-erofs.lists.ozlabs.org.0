Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DD25B8761
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 13:42:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSJN45Bmyz3bbj
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 21:42:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=htDGENuQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmpxchg.org (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=htDGENuQ;
	dkim-atps=neutral
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSJN01dDBz2y6N
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 21:42:07 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id t7so25205951wrm.10
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ljBV21/rt7xHP9hdJuGiN1G45ZLlbidyAGuNrkqe6Lk=;
        b=htDGENuQtq43qhmWgK7QIRMzYBo6296bz8Vfw5UgOVKZ1mcdLlzO99Kys9b4mbzGYE
         4DpKNNyMMJeUEPUvTkivHDmudn9erl8Xl5QVjIrvZjxSjlkpNcWcrLq7NqMqezjBFJ59
         cwiC7FtsOZESPb+E3lPsrCe/6DfsuS/zqHVNiXDQ7oB6WYaRGsY8jEvQs5HGRNYErn91
         /bxE6hl6HRLgl4dbe/rxfCiM5GKxQEs8nbbVUkBRhr3Ns9712JwjQ393UNHnFDAx9LR6
         tJyFmwqQZf6iIlSL0WaJBKA0bHpRHYUuBlWUR/tm18RG6me+1gj2hyg/OH06AhyC8lq4
         0KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ljBV21/rt7xHP9hdJuGiN1G45ZLlbidyAGuNrkqe6Lk=;
        b=ehd2raXfoFOY5olq/rafu2Njst17osh1eU3jof+YLrCHZX1P2aLs6sv5Yf7+WVayjN
         jb5et3qS3L/S/KVXuN0rpgAj2vDh/rCfIrtXJSnUqF6yGW0+g6WwvLLE0TYG5HmSuyRD
         0cQ/E7ARxH/wAmR+V4Yz6/GRE8H6l7eSf6kFPTrTnkfP2nvehPwkyXpny1/E8Ddluxjt
         /XUbw6OYAwNByPKvxyMF+k3i9IuYZZK0OSciUMH4De0dZyCx8KQ507gRQUzy0JeU2pDo
         2mw8SXiZ29LVyM/mmMnVFAIKrskLp0wXsizRzW5hoRMmj8FWjc+lY79zIYQcao9XLBG+
         RDfw==
X-Gm-Message-State: ACgBeo1db2/c/7ARaonMuf1ATuM3LLyAiM9kPoBCtoZqrA7TigRXqqnr
	FAU+eRoBMEgd29c7EyN9Gmx58g==
X-Google-Smtp-Source: AA6agR6IfcvPiHVBT59W7/ls00SW+xc7QmxOy9km38ZHpiVJXWOLMisG8CvkNAYucyBoYWbKMvVNgQ==
X-Received: by 2002:adf:a28e:0:b0:22a:7428:3b04 with SMTP id s14-20020adfa28e000000b0022a74283b04mr10099863wra.75.1663155724464;
        Wed, 14 Sep 2022 04:42:04 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003a2e92edeccsm5210267wms.46.2022.09.14.04.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:42:04 -0700 (PDT)
Date: Wed, 14 Sep 2022 12:42:03 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] sched/psi: export psi_memstall_{enter,leave}
Message-ID: <YyG+C+z1n8d1Alty@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-3-hch@lst.de>
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Sep 10, 2022 at 08:50:55AM +0200, Christoph Hellwig wrote:
> To properly account for all refaults from file system logic, file systems
> need to call psi_memstall_enter directly, so export it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
