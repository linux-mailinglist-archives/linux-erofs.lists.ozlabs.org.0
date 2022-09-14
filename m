Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA175B8775
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 13:47:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSJTn0fkVz3bbj
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 21:47:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=x896VLq/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmpxchg.org (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=x896VLq/;
	dkim-atps=neutral
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSJTf0vfTz2yMk
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 21:46:59 +1000 (AEST)
Received: by mail-wr1-x42c.google.com with SMTP id bj14so25235068wrb.12
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=R0+X/Vt8U/YJmmqx4EaockLsNUJKMLE86zCLujidRXk=;
        b=x896VLq/0T8z+7Ik2gVEyES3l8Hvh2btFLNkRDkyFPILpk8pTXgwHjASSECXNYjAWz
         /4nzKNwpCXNTkvMp3wIXm+yfyMEvJgbc0MMk3D9eqte3BBV33uNDi2zp5DN9H7jUKXIY
         QXvEQyfRrTQbfi9CRmk38OQyufCqNJxtBsi780ZltRwyVkT9bfkauohtiuVyIg+158uh
         +dFEzwIdSyjmXHrCx/K924lHgmJPmWJYLsCwaV9AGTR61qVUxaiMSZ2OhTc/JpkYvAPH
         4lWJuFbIHC8bixWnUFa+49kysfkp6O/h1VUzL+fvL4Iut0DY7EPkgG7OYYgpkJLQBkQf
         Dppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=R0+X/Vt8U/YJmmqx4EaockLsNUJKMLE86zCLujidRXk=;
        b=X2KAw6ugTM1In84wpEOs9dHntqwsL74SWk2EekEze4c9JNw9172BCrm+akbFgYnwFB
         Fv5ivbtNQ2TJvYd9Ai5SLhe8x1qrng64ip4SEQU+NA97J9jmyxTvolukCoLuGIeohtp+
         k48MaxU60/dQ6ouOQsCN3lCm7cUYm4NpBq/FB8K01WisvdRdi26X7i7PIpQyZOtq9Xre
         mRfD0fTfad9Gwu1hBHImObA7DOaPPEAguon6eeD4fufXh292bBJ6xxYpN+6fsZ1R5vba
         5TeOwTSbJowtRcRh066vECWjiQD0gYo/q1DcPziUn2eTkI5MjhIE2fsw2QakPnYneNvA
         Tgkw==
X-Gm-Message-State: ACgBeo0NNDX7+pERrwwIzHgthTcOqPiWpffNALSO8YznQLHSXBH9AAvD
	jGKD4DG9I5ylWIhpGR/J5EagXw==
X-Google-Smtp-Source: AA6agR5rGXGDLe/tOLWmuZc+R9A3yuqUfg5LeZ1FohTf0HB09NHH8ytKek+mH6dzb5U83k4gaIwQ1A==
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id 10-20020a5d47aa000000b00226dbf6680cmr21226454wrb.581.1663156014968;
        Wed, 14 Sep 2022 04:46:54 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id y25-20020a05600c365900b003b483000583sm11359663wmq.48.2022.09.14.04.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:46:54 -0700 (PDT)
Date: Wed, 14 Sep 2022 12:46:54 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/5] btrfs: add manual PSI accounting for compressed reads
Message-ID: <YyG/LlF7TbdHSCsm@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-4-hch@lst.de>
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

On Sat, Sep 10, 2022 at 08:50:56AM +0200, Christoph Hellwig wrote:
> btrfs compressed reads try to always read the entire compressed chunk,
> even if only a subset is requested.  Currently this is covered by the
> magic PSI accounting underneath submit_bio, but that is about to go
> away. Instead add manual psi_memstall_{enter,leave} annotations.
> 
> Note that for readahead this really should be using readahead_expand,
> but the additionals reads are also done for plain ->read_folio where
> readahead_expand can't work, so this overall logic is left as-is for
> now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
