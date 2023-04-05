Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9CA6D8A6F
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 00:15:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsJpf2s2Dz3f8N
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 08:15:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1680732906;
	bh=sr4CJdOOx/6apQcfPjVNK8msYC2J6U4ttJpvFiO5hDA=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Z0VdLMGazIZcoBLu6tN/fl/JM/1H2Ohilz+GBgey2zxbeQjKT9UDtof74vvC1bpdC
	 kSM069JRYQL0pMryS2Qmuanf/3xQXcUOTn70o6OEUVO9tFfjAWNNkHI4ZR40c9WA+v
	 Yi5JuomjGa9k9agm6im1OlNyrDTUpMzRu6fu1wvVA8XcddqyknT4nCNEPlfLc7MuMc
	 c6lUC3P84nBdSvI1UAhvMu1qPK43uXlEUXbFQ+qVREWPFD/oqDMEgJABEUajI50MQk
	 h3BNG5tCZ5+s0BenrnY5esEtXn0KXHgzaAvv2uwO0pInqm9aE70N/4i3WWzHAxPfqW
	 /Bx1Vu5rujq0g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=david@fromorbit.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20210112.gappssmtp.com header.i=@fromorbit-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=m04BZY35;
	dkim-atps=neutral
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsJpY5rrBz3c41
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 08:15:01 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id z11so24658319pfh.4
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Apr 2023 15:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680732898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr4CJdOOx/6apQcfPjVNK8msYC2J6U4ttJpvFiO5hDA=;
        b=WksQNj5XF4Ke0q5Q0K9tmRCsAAuZfPtrhGGD/RHe3Ms7wP08w0Phd4IwRtkJAwmgNC
         HOPdCYeaLA8tFE/0F6ZHDrvuWgk9buLmxZqSUDRQUFtLXUmzUvUJOwZ2wJiHj9qHuVAD
         VSSXQiTmujIazEoGLeqRy7ezgRJcikDyc7GEmPEUdTej9FIdfwDApnQXMPwvLqUPjAOV
         8arXzrcLpbU4UGeiRtIo04TKprp/UVYZfjf45m5lZN2RWXubhkgNZ+ahfgo2Sr4WSkva
         BAMHrwOgYB1dAwsDEEfDshAVo3ZzREfSQPCsJfZAb2aPze7UaDOwkNwTZro29MBb0ORA
         +nlg==
X-Gm-Message-State: AAQBX9dqE/c4eiFlXsw31NTwm01ypOFok9RkScwQqAFNkYKR+rDtOKzc
	0ZgdXKLHo91AYGVeHpvBNUuljw==
X-Google-Smtp-Source: AKy350buwNZtgpjQjNrpY+dRBomVST4nFtdRBnQ6Mea8vZue8EC+2ZTK97MNMJLE5y0NZdZDQ14O+g==
X-Received: by 2002:aa7:9a44:0:b0:626:1c2a:2805 with SMTP id x4-20020aa79a44000000b006261c2a2805mr5960988pfj.25.1680732898541;
        Wed, 05 Apr 2023 15:14:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id t17-20020a62ea11000000b005a9ea5d43ddsm11542560pfh.174.2023.04.05.15.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 15:14:58 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1pkBP4-00HUS4-Uz; Thu, 06 Apr 2023 08:14:54 +1000
Date: Thu, 6 Apr 2023 08:14:54 +1000
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 19/23] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <20230405221454.GQ3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
 <20230404161047.GA109974@frogsfrogsfrogs>
 <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
 <20230405150927.GD303486@frogsfrogsfrogs>
 <ZC2YsgYRsvBejGYY@infradead.org>
 <ZC23x22bxItnsANI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC23x22bxItnsANI@gmail.com>
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, "Darrick J. Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 05, 2023 at 06:02:47PM +0000, Eric Biggers wrote:
> And I really hope that you don't want to do DIO to the *Merkle tree*, as that

Not for XFS - the merkle tree is not held as file data.

That said, the merkle tree in XFS is not page cache or block aligned
metadata either, so we really want the same memory buffer based
interface for the merkle tree reading so that the merkle tree code
can read directly from the xfs-buf rather than requiring us to copy
it out of the xfsbuf into temporary pages...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
