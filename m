Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2533D9681AD
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 10:26:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725265569;
	bh=UhT3U5zyLILdoM1tyZBb1t7DNlyeif+DRzYH4+w3qmw=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dEAIIROxRb91DT7akp0fkh7FvT7idIs402aOAcOkQIGll4fkZgyUw6VjTVnCfOT3r
	 wtBbNwRy1PnwfSf9zkbd+R4zVtmXZHq7WyjnevgVF1jkE2s008W7uwnQPY0NXIJR4I
	 smvB6K7b6zRitMqUOcz/1Y91oBQoWK3B+y4jo9xHJs/0/5AQcLQ5tJ0zFWHfYq10WA
	 aA0tGVtKwT3Rcusk3rBJupQY7qOlsxkGthorXPzRu11ba6PgJhtZ8NkBvZvCmv2D02
	 RfDpC5WI6VqE7dIRqGBHL27YfFu6tWv5BT1AqvyskS/4zcMmJCENar+uKJ5y2cUIYu
	 f+tnIi6Bj+WPg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy2015vpJz2yNf
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 18:26:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725265564;
	cv=none; b=e3U3cnGdDeL0hPxU6QD52wYLxIpZ/LteJo9imgM8vAEwzjjZyPOrQmDqXpsdz5QuagZimenmnhKO3FYBuKMID1raoBspQS4FTazDbwPisn2VB/kIv/AVKwXKS3LPgbFqkfdloBpTf9WwbEBjqQstKhjTJspsA7RTbBZvARdxwBFK6wdS7S0MCmhfgwi3VGMV1ouyOrGus5DWymJW7/Vx/eO1KE+9OBaJZTYviVCbrvtTtH09Tduxcg3rzFjkvOvSGN3lfxzKCQ9+oQI06pkhojelChF4cZE2NXe+Wf96bc1cyLZs35mVibVzRqM0P7815xNCxpYww5hPuuKP0HMFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725265564; c=relaxed/relaxed;
	bh=UhT3U5zyLILdoM1tyZBb1t7DNlyeif+DRzYH4+w3qmw=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version; b=RUeMfbZ8uz51X1mewEGDHxxahy0BnCduJuVV5KQ402djcbtrSSiY8Uw7ChcXWLM+4GhKKdvR2IWByleP14EJQuuTbtJ7EKfi/iFqJqianGQSi/wbBNBvisCVQPTl4g07+xGhWdmZuLZLlH3SYE+yBQpWDKKNckPPVTzlB1HSOyfOInACMcsnlWa9S5WVW4bP+LLXhyRBoYQ3PoBhf1bAwD8q9DOvg/OsqxiEfMkB5e4YlSXpcFxarJx3J5lRd2h7YCTGTkZL8e0e4pkchry+ki+vFv9B7Yz6X/JvW0Wczxnjx5GSfFt2MEaqEctW0DKIW4Jr24IAe5y9WWgLRyACuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=Getyq49N; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=Getyq49N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy1zv4TYqz2xdY
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 18:26:03 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 567E9697D1;
	Mon,  2 Sep 2024 04:25:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265560; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UhT3U5zyLILdoM1tyZBb1t7DNlyeif+DRzYH4+w3qmw=;
	b=Getyq49NqDeqVZkMt1QZ3Cf7CeW/swOruiVOs46r332V1ZklA6kLb0igYL308Q1rFQSox7
	H3K2Ghbq0h7pdLPUV5wnYk/meW7nmTDALMhr62sUm5v344Hc3l4XfUJwYc2C1xcsqjOHuF
	mOnE0o6TAneEwd/9Et0FTLZK3pYvZguSL/J5GJg0Gc4oN6R/yM/8VMC/9Q8jOt3m2y7GVK
	vWj/57/Ces9DGLRnfu0zcvERy6orpt2GiOzOuMj3wqWVN6jvABohHF6Egm3Yjdye5HVg/K
	bSW2vtpfCY35T2hztsmE4ohsfrjUHWRv7XGsvZwPZmwkaAjpNRdhUYg6/fNKow==
Date: Mon, 2 Sep 2024 16:25:52 +0800
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH V3 2/2] erofs: refactor read_inode calling convention
Message-ID: <7d5r3gf4drcyraiahnuwo6ia5czursu2s6bd4jo4fcizhgwqhk@6qwnh7kn53qz>
References: <20240902080417.427993-1-toolmanp@tlmp.cc>
 <20240902080417.427993-3-toolmanp@tlmp.cc>
 <1cbbd501-bd81-4df8-a887-8c07e0469ae1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbbd501-bd81-4df8-a887-8c07e0469ae1@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 02, 2024 at 04:12:31PM GMT, Gao Xiang wrote:
> 
> 
> > +static int erofs_read_inode(struct inode *inode)
> >   {
> >   	struct super_block *sb = inode->i_sb;
> >   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > @@ -20,20 +45,21 @@ static void *erofs_read_inode(struct erofs_buf *buf,
> >   	struct erofs_inode_compact *dic;
> >   	struct erofs_inode_extended *die, *copied = NULL;
> >   	union erofs_inode_i_u iu;
> > -	unsigned int ifmt;
> > -	int err;
> > +	struct erofs_buf buf;
> 
> Should be
> 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> 
> Otherwise buf itself will be left uninitialized.
> 

My bad, i forget this when rebasing. will be fixed in next version.

> >   		inode_nohighmem(inode);
> >   		break;
> >   	case S_IFCHR:
> > @@ -269,7 +266,6 @@ static int erofs_fill_inode(struct inode *inode)
> >   #endif
> >   	}
> >   out_unlock:
> 
> I mean since `return err` is the only useful statement for
> label `out_unlock`.
> 
> You could just remove it entirely and replace all
> `goto out_unlock` to `return err`;
> 
> the name `out_unlock` itself is also meaningless due to
> this patch.
> 
> Thanks,
> Gao Xiang
> 
> > -	erofs_put_metabuf(&buf);
> >   	return err;
> >   }
> 
Got it, will be fixed in next version.

Best Regards,
Yiyang Wu
