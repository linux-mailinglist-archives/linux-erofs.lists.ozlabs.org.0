Return-Path: <linux-erofs+bounces-11-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB9A540AD
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Mar 2025 03:30:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z7YLW05s0z3bmL;
	Thu,  6 Mar 2025 13:30:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741218112;
	cv=none; b=U9dHIpbV2y9nN/upu2+xDZP0Jfml4D1WaDoqljCwbaaNS9vITLaP1lbWCaFfWjU6MPerezs2Ehce6SlprH2+qd8RXKbwZmxb/qU0XHwC2t+sOln/3ddcBuKrWSmnrVtNKvaZPtpDwd0UsnNv+OB+0UCpQ6bLe0kM4otW+wbHuyQCcXJK8Oqm42JlXqK3rIPTElO5IKuUc3F8g7pJdkhQSTnfQLRBbGwuyhd7HFqs7MiPd6VoniCZxKpSO0plnUGlhAPR94jvshxIsd4grqVq6+5XuKtI/SYshpUFHTWmqr8vUsfDZi0Oxnn83frdybjazve2jwGkTHjVkSC31zZqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741218112; c=relaxed/relaxed;
	bh=evnk/GxliDTjNMMgAFyfCNZGfvqVt47nI9LnubvMvxc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=KeT8kvl/ljG/WITxw3whKFqqR+eoUjaKMl3a88Ovh9YC8Ju8mBZPOSFELKUZoQADjer1XraohuCA62bXqjFIP2aqg6ngZLHfVyaxFyQ2MzTb7K+/bLs573Zc/+yF22IwihKh/FAdFIKVZFeLfwxpTCeYpidHXQd5wKI0HyxoauFngfP8n50As7yzG5cPR6F9leEnjC7utkb8CazChZgm5QdhP6zboXpB5wCRRlkJrnXiyZAPY8ZiHJ/sVsm82k0+BXzIOG5C05Cvh5zI8go4xEX1hQ9gl2ORifsA6+cY/zD0dclbMEbrr05B/mTmP+z8y0lcqVKk7E092EH8F11mJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YjCN5sm0; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SeO+07Dw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YjCN5sm0; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SeO+07Dw; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=neilb@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YjCN5sm0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SeO+07Dw;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YjCN5sm0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SeO+07Dw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=neilb@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z7Tbf1Qsjz30Vr
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Mar 2025 10:41:50 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B7C171F385;
	Wed,  5 Mar 2025 23:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741218106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evnk/GxliDTjNMMgAFyfCNZGfvqVt47nI9LnubvMvxc=;
	b=YjCN5sm09/Vik1hnIVgY/KAn9Bl+M9/Qo0xPTOFQNF8Y/8QdKDvee6BGLO7x9pn9iJ9kyi
	n5vDga3YY2IqVkMq8j71+tXA/lQqxgbYINFt4chYC7lsJ2wAc09oTXOcOZ0cfwMxqE/8JT
	f5K7ko5CR+elv4J6T28XRXDqa8DqvvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741218106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evnk/GxliDTjNMMgAFyfCNZGfvqVt47nI9LnubvMvxc=;
	b=SeO+07DwVmMuxGIdJ6uBjWre+ET8YmfEvWdD+64YO1xDmbJOxMvVwYwNFQ+y51t6511CM8
	Xk9d1WRKq6le82BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741218106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evnk/GxliDTjNMMgAFyfCNZGfvqVt47nI9LnubvMvxc=;
	b=YjCN5sm09/Vik1hnIVgY/KAn9Bl+M9/Qo0xPTOFQNF8Y/8QdKDvee6BGLO7x9pn9iJ9kyi
	n5vDga3YY2IqVkMq8j71+tXA/lQqxgbYINFt4chYC7lsJ2wAc09oTXOcOZ0cfwMxqE/8JT
	f5K7ko5CR+elv4J6T28XRXDqa8DqvvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741218106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evnk/GxliDTjNMMgAFyfCNZGfvqVt47nI9LnubvMvxc=;
	b=SeO+07DwVmMuxGIdJ6uBjWre+ET8YmfEvWdD+64YO1xDmbJOxMvVwYwNFQ+y51t6511CM8
	Xk9d1WRKq6le82BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E44A013939;
	Wed,  5 Mar 2025 23:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zc4kJSzhyGdbdAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 05 Mar 2025 23:41:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
From: "NeilBrown" <neilb@suse.de>
To: "Yunsheng Lin" <linyunsheng@huawei.com>
Cc: "Qu Wenruo" <wqu@suse.com>, "Yishai Hadas" <yishaih@nvidia.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Shameer Kolothum" <shameerali.kolothum.thodi@huawei.com>,
 "Kevin Tian" <kevin.tian@intel.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, "Chris Mason" <clm@fb.com>,
 "Josef Bacik" <josef@toxicpanda.com>, "David Sterba" <dsterba@suse.com>,
 "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>,
 "Sandeep Dhavale" <dhavale@google.com>, "Carlos Maiolino" <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Luiz Capitulino" <luizcap@redhat.com>,
 "Mel Gorman" <mgorman@techsingularity.net>,
 "Dave Chinner" <david@fromorbit.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
In-reply-to: <18c68e7a-88c9-49d1-8ff8-17c63bcc44f4@huawei.com>
References: <>, <18c68e7a-88c9-49d1-8ff8-17c63bcc44f4@huawei.com>
Date: Thu, 06 Mar 2025 10:41:24 +1100
Message-id: <174121808436.33508.1242845473359255682@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,nvidia.com,ziepe.ca,huawei.com,intel.com,redhat.com,fb.com,toxicpanda.com,kernel.org,gmail.com,linux.alibaba.com,google.com,linux-foundation.org,linaro.org,davemloft.net,oracle.com,talpey.com,techsingularity.net,fromorbit.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn),to_ip_from(RL4q5k5kyydt8nhc3xa4shdp4c)]
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On Wed, 05 Mar 2025, Yunsheng Lin wrote:
> 
> For the existing btrfs and sunrpc case, I am agreed that there
> might be valid use cases too, we just need to discuss how to
> meet the requirements of different use cases using simpler, more
> unified and effective APIs.

We don't need "more unified".

If there are genuinely two different use cases with clearly different
needs - even if only slightly different - then it is acceptable to have
two different interfaces.  Be sure to choose names which emphasise the
differences.

Thanks,
NeilBrown

