Return-Path: <linux-erofs+bounces-125-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE9A6E9B1
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Mar 2025 07:42:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZML2H5NBDz2ygL;
	Tue, 25 Mar 2025 17:42:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742884951;
	cv=none; b=kt5XgGwX9j888oRr+kTGmw9P9OsSmz/WIERA7TV/8qDqUraUGKruU4r9LlC1oXCJt1OGJicIrOmmIAal/yf7TFQXHs2AJrD1wU4SiSlvlbOEXMw7azEhNzYOvjwN0Ei5iPhQZIHi5V0x7Kjk+U/ednrAU+cshCgl2ezjTptU3ttpTtZogVXWjDtQ/udtKg74YyR6d47lI3St/cFq+u4Pss6biaJDlLeTI9SY1ounhjk3Xy2C+UFqOpBNdKP1yMpK+BuCwAKRuQDjh6XtVZST5xTITOuQSf/LLom6bHwIgqgH5D0VF2imrt/3RIMod1KvqgEDN7Q3u/E1qx4ULwwi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742884951; c=relaxed/relaxed;
	bh=XXwI8dfCcwC4g4BUCUZgxrLvKM1Snxm0aSv7x3EVfic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3OfepzIQsdckXwdiT5JYVNWOhpJQjvKTFbRV3BPCvb4FVt0/DQz6//VukU7O/axaKJ/wFo7QC30RamB3rar1yNN52WSrhagJWnnbzGQrD/mDXjH0BvBtkrzu2easI/A5JEY/8yazJsOruI69hnJFvPKaBVWVgo0O4SwhE5c5S7A0GZMZPgqByqmpjeQetoptEAaefxh+5dAEp/XlUnqBJDOdFS6dYwAoyZ7ImrITIi3KMq7fXconnH9hfQx8SaKIaPlYnyAjp5klP/DLmcA8CRQdR7LXjXe6w+pfrHgmcrboSgy8OFShraVSQqUpDKHDQaIqcZF0TVl48360woDuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yWw076pz; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eE53qwTu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yWw076pz; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eE53qwTu; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=ddiss@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yWw076pz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eE53qwTu;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yWw076pz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eE53qwTu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=ddiss@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZML2G0BcWz2yZS
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Mar 2025 17:42:30 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D52E21179;
	Tue, 25 Mar 2025 06:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742884938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXwI8dfCcwC4g4BUCUZgxrLvKM1Snxm0aSv7x3EVfic=;
	b=yWw076pzQgxu1rGu3pGJJiK3uS1kUhcN0l+dxjgUXioApt3CGt4OJC1QLS93un/klqhnEs
	JWbazHfYw6pJ5hb0ry6bHXjTRTP1foaj0d/PgZEo5WwE6eqigkf0qrtQri0tBUQL0NUdYW
	IEVJouBBZtEzPu8zvMqRGegMsq5SykM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742884938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXwI8dfCcwC4g4BUCUZgxrLvKM1Snxm0aSv7x3EVfic=;
	b=eE53qwTufrzx0xlgjcug5ixl2lqozCkcSQRofYhV86v39ssDlyDNjwCgb6J67LElRT/swu
	J2dcwtzHEwMw7lDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742884938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXwI8dfCcwC4g4BUCUZgxrLvKM1Snxm0aSv7x3EVfic=;
	b=yWw076pzQgxu1rGu3pGJJiK3uS1kUhcN0l+dxjgUXioApt3CGt4OJC1QLS93un/klqhnEs
	JWbazHfYw6pJ5hb0ry6bHXjTRTP1foaj0d/PgZEo5WwE6eqigkf0qrtQri0tBUQL0NUdYW
	IEVJouBBZtEzPu8zvMqRGegMsq5SykM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742884938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXwI8dfCcwC4g4BUCUZgxrLvKM1Snxm0aSv7x3EVfic=;
	b=eE53qwTufrzx0xlgjcug5ixl2lqozCkcSQRofYhV86v39ssDlyDNjwCgb6J67LElRT/swu
	J2dcwtzHEwMw7lDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2657B13957;
	Tue, 25 Mar 2025 06:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hUDwMkVQ4md/fAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 25 Mar 2025 06:42:13 +0000
Date: Tue, 25 Mar 2025 17:42:03 +1100
From: David Disseldorp <ddiss@suse.de>
To: julian.stecklina@cyberus-technology.de
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Gao
 Xiang <xiang@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 1/9] initrd: remove ASCII spinner
Message-ID: <20250325174203.67398632.ddiss@suse.de>
In-Reply-To: <20250322-initrd-erofs-v2-1-d66ee4a2c756@cyberus-technology.de>
References: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
	<20250322-initrd-erofs-v2-1-d66ee4a2c756@cyberus-technology.de>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

> From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> 
> Writing the ASCII spinner probably costs more cycles than copying the
> block of data on some output devices if you output to serial and in
> all other cases it rotates at lightspeed in 2025.
> 
> Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> ---
>  init/do_mounts_rd.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> index ac021ae6e6fa78c7b7828a78ab2fa3af3611bef3..473f4f9417e157118b9a6e582607435484d53d63 100644

Looks good.
Reviewed-by: David Disseldorp <ddiss@suse.de>

Will wait for v3 before looking at the rest of the series.

