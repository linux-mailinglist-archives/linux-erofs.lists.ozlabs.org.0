Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 824485B877E
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 13:48:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSJWC2gLRz3bbj
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 21:48:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=FuvRBy/Y;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmpxchg.org (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=FuvRBy/Y;
	dkim-atps=neutral
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSJW74d1Pz2yMk
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 21:48:19 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso11383178wmb.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 04:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ekhj2cbi3pFqj5WaOvlPJtFmfVNyvuw6Du6P5WWhCmQ=;
        b=FuvRBy/YDM9LvorkFgZMIarw2akZH9vRnqqyhXP4k4jBOCqDTdBb19LVMnYiY8f/KT
         Ac8yoGMc0IM7/slzBhY+mUCg70lPo4PTje6o4SeKZfGlbpbep8XuBNqGbD1vPCk3SQ7/
         k0/fIt9gCA/7yY9b3TuFHeyaudSHRxPL8W/uv2JsW9w5PhZwyFvP66FkbmQ4vdMDliSF
         U6oj+1Ag2EPqDq3bYXfISpy8s7xWiAIIm70MSaPiR3gvV+pa1mKtP5n8Un8YJxCaXTsU
         +jehRcd4Tur+HMGOVDfj1OkDtsXFw1Ij31j8iYZdnQDYyNwrqDF6ajaYSf/hlAW+igEL
         tu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ekhj2cbi3pFqj5WaOvlPJtFmfVNyvuw6Du6P5WWhCmQ=;
        b=wt7jEh0EaJUceRnXkDEinPYhzGXSOT+9SZn5M53jKBGUOYfU74+rb0BiWYoE2c2lvc
         MAzxCRPSrHuvqP60gDqtn44wfqdcHGLzd/7L//Vsh38NSw1EXFySDCgnHkHfS+ltRkwq
         UMoOeeq+SxUxGpijDcax5SYhsAZimxwuAqZDOnZJ190OYLgM8gzHe4PqORffw0pJn2N1
         Qz3d041bQiMZW6ops73gGvea3+VxYi3x6f6N1/gVU4cOMuwI8JCz61cACHPXi1pBb673
         ColLEoG+CHl2GxNExRuq665NXlRrUwLtQC2kWxY0EEErsEvpKm3Wgh4cOcc7+8SVW1AU
         Y/zA==
X-Gm-Message-State: ACgBeo10LBwIUsJEwtDEYzUc06a049Fz4Y5O+X5cfVSuxcoiXoUZLjku
	RZtYqP26sQ+cUACTtg45ud6jgA==
X-Google-Smtp-Source: AA6agR5ezVjBKHmGNFAxhaPLrFFF0Krm6Pp93Ol6cKN8R23OK6bW1ticeztjxY3umNpndws1iPQzIA==
X-Received: by 2002:a05:600c:4793:b0:3b4:7276:1c5e with SMTP id k19-20020a05600c479300b003b472761c5emr2866737wmo.118.1663156096067;
        Wed, 14 Sep 2022 04:48:16 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c198c00b003b47e75b401sm13069133wmq.37.2022.09.14.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:48:15 -0700 (PDT)
Date: Wed, 14 Sep 2022 12:48:15 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] block: remove PSI accounting from the bio layer
Message-ID: <YyG/f5AjkcKcbC6K@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-6-hch@lst.de>
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

On Sat, Sep 10, 2022 at 08:50:58AM +0200, Christoph Hellwig wrote:
> PSI accounting is now done by the VM code, where it should have been
> since the beginning.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
