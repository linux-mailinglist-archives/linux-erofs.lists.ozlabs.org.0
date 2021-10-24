Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8F438C44
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 00:09:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hcsh76hqWz2yZf
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 09:09:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=EYp64EAX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::833;
 helo=mail-qt1-x833.google.com; envelope-from=kent.overstreet@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=EYp64EAX; dkim-atps=neutral
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hckp96jTQz2ynG
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Oct 2021 03:59:28 +1100 (AEDT)
Received: by mail-qt1-x833.google.com with SMTP id o12so8245836qtq.7
 for <linux-erofs@lists.ozlabs.org>; Sun, 24 Oct 2021 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ZzV9v+7pJvz9EKj7cbiV3TsfyLtsPrvdzBHt6l5taGA=;
 b=EYp64EAXnertXUdBpDT9U0CgdT2YctRH80w0R74nJWL9Y/0ekIpX1fV1ZjL8b34I6n
 Zw90bNaEOCH0wE0qW6CiKyPTGgQiy/6a4BhTqvp1DpTvnV+lVTiaqPbMr339UMyRNFis
 tptKPLqBJ5LQ9mnKPOfQGIf8LIU7Sxtrq0hX3L++29pzze4c3YdU9rVrhGV7UOAVao81
 hkmaov6ii8+7oUtO/taKluRnsx+nrZyZbocql4MANz/o9PaRJewC6cMC2sR7VV/8Zwea
 MAyjGm/M+8On28SuVEyzXy7FdXKPtw/oWYIQvHI/5dcobLVY9PbLLAHum0zPWo2Hw0/d
 WlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZzV9v+7pJvz9EKj7cbiV3TsfyLtsPrvdzBHt6l5taGA=;
 b=5quV1obg04lGBajJGhiwCnZ1GIQiloyepuQESVdxomBNLCdeW5JoMLJ1NZvPhOxfrU
 gOlOPMhbkAAFC+NH9hLG+FE35/0BXf2dBdvdcnp828enUelr67xt0FAAuPDV4+sT28d9
 ph7P1cLgYLwgAvwG07tK/75Wwti3GPshnMu8fcfU1MkYQv2Ra18Iy1qROBpu8wL63/88
 gdj7IUW0rp9sjrKBjqsQMnIoXuYYRE49cmoVw7e0Mc7eds082wkwsndmXvwAfxo9WoUi
 wTiFJP8ofo6p/mbPXhsmgCD0TlVO2jP2C8ECQrnLY2ISrRTcJBHlPfcZ/UJWOmEvRoKR
 JYig==
X-Gm-Message-State: AOAM532mMMqvnZ+QY9EDLiHfPXk/WkRDWDdnqGfAl6BVz0z4e28AnG+o
 5ku9WDZX5P016Cr6S7i/TA==
X-Google-Smtp-Source: ABdhPJzMJaqe0tBgAhV2ds6pekgjv5fUqZLbGH+NyfcBg2Ff0zdCLT+GgODdOvE58VWHym5iZWoQ5A==
X-Received: by 2002:a05:622a:c7:: with SMTP id
 p7mr12830518qtw.356.1635094764478; 
 Sun, 24 Oct 2021 09:59:24 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net.
 [73.219.103.14])
 by smtp.gmail.com with ESMTPSA id 12sm7779026qty.9.2021.10.24.09.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Oct 2021 09:59:23 -0700 (PDT)
Date: Sun, 24 Oct 2021 12:59:22 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: get rid of ->lru usage
Message-ID: <YXWQ6p4Hlx6tGpPN@moria.home.lan>
References: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 22, 2021 at 05:01:20PM +0800, Gao Xiang wrote:
> Currently, ->lru is a way to arrange non-LRU pages and has some
> in-kernel users. In order to minimize noticable issues of page
> reclaim and cache thrashing under high memory presure, limited
> temporary pages were all chained with ->lru and can be reused
> during the request. However, it seems that ->lru could be removed
> when folio is landing.
> 
> Let's use page->private to chain temporary pages for now instead
> and transform EROFS formally after the topic of the folio / file
> page design is finalized.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Would it not be an option to use an array of pointers to pages, instead of a
linked list? Arrays are faster than lists, and page->private is another thing we
prefer not to use if we don't have to.

That said - this is definitely preferable to using page->lru - thank you.

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
