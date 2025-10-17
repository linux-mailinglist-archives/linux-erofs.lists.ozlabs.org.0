Return-Path: <linux-erofs+bounces-1259-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E81EBEA7F0
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Oct 2025 18:09:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp8sv114Bz3cZn;
	Sat, 18 Oct 2025 03:09:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760717395;
	cv=none; b=f2Iy54PLVeYb0mFq6AGSnpWrjGaNVwvis/fOzCFMARy7GymYO5KIUtkMGBQDCjqEDn1gq0QSm0opZNjnxzr/uItaDbDHgEGOFSdJK9vTWnkCeVKm6o6XLNHix096H+xP3plqJ+X7/nX/laoJRWAOU5Ay93FeuWedRQ1XzrhYl6+NbhMVww8W86AvNLTifLP2sPh08SfyHASxupTX2QpQT1E5XKDzV56Azkd6toRTOqhertYnb2rx2Rn6W8w8MpI2pwKk+MvMVUW8nl49wSEKh01WrWnXvwE9DCOxaYPeZsWEzknBsjX0SbyPHA2HWHqQFK1CW/pFrYlj2O+VCBuMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760717395; c=relaxed/relaxed;
	bh=nX+mtnNcQcWlv9JGlUu/KrtXpqebuR7wZinuAUmv6BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=El+9VpXrLfweyiqycJcgfFWwKiSGHhH2KAJtzsbTvN2HBrck/8707bNltjeoznHW5dMY6LP8SiWC+R250J6y8FtyVwyOJBlnvT+zCgTmNGdD2X0dgn54HHNzHPYTxoG103Cq8eaz582UoksO6hHaXCCNFM6nrAvHgwqNb9IONL3s2FEZT9yObkCE+BJvLPmU+V8x4ez5qLsZuqaBMRArXCW0NK/iml+Pzw9iUWlRrEpBdAXCUHt5QvjUhss43Gggv9IygB+RNA1M7nvqJNEfID8qOhzfQWS4eZLkQcMatwSI1TXsvVs6n8gI9g5kBEuHUuDluXYfd9r0HgpNvzHslw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YtSviiKK; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YtSviiKK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp8st26KHz3cYP
	for <linux-erofs@lists.ozlabs.org>; Sat, 18 Oct 2025 03:09:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 19A6443AD4;
	Fri, 17 Oct 2025 16:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE17C4CEE7;
	Fri, 17 Oct 2025 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760717391;
	bh=BOrYC+tXjLjRqJyXcD4crvrBNK2lkUpKkjfEmyc87bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtSviiKK7XhOypmn1B0JMTFJNg+aK9xkicr5kleBJoGLQsIHX6oRtRnPJgXbXWtLH
	 cVrvwZYIhcft0nkxK/ZQBpXxxHeWHw5/VEilYnGTD4lEZyzXP8wqDKjbklEc7PQZxX
	 jrw7mNWuagcjs3SnKes4mzFKMKH2tiSDMTY+zRgHS/b+KVlZKnLK4gb6spqja1+1F5
	 LtRKkkOtABvH8jmUIF+maywb5ma9DVPFdB4So5FQ7XdD3Y3FN97CNzQWMZICjSRgyi
	 XbXdYmBkEWUiq556ItdRa+tvmxGUk+V9ozsqtDgWFGhyHQtvMVM573eif+FMsCQ1J7
	 ilRe5q/VN9eDQ==
Date: Fri, 17 Oct 2025 17:09:24 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org,
	linux@armlinux.org.uk, jdike@addtoit.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	tony.luck@intel.com, qiuxu.zhuo@intel.com, mchehab@kernel.org,
	james.morse@arm.com, rric@kernel.org, harry.wentland@amd.com,
	sunpeng.li@amd.com, alexander.deucher@amd.com,
	christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
	evan.quan@amd.com, james.qian.wang@arm.com, liviu.dudau@arm.com,
	mihail.atanassov@arm.com, brian.starkey@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robdclark@gmail.com, sean@poorly.run,
	jdelvare@suse.com, linux@roeck-us.net, fery@cypress.com,
	dmitry.torokhov@gmail.com, agk@redhat.com, snitzer@redhat.com,
	dm-devel@redhat.com, rajur@chelsio.com, davem@davemloft.net,
	kuba@kernel.org, peppe.cavallaro@st.com, alexandre.torgue@st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, malattia@linux.it,
	hdegoede@redhat.com, mgross@linux.intel.com,
	intel-linux-scu@intel.com, artur.paszkiewicz@intel.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	sakari.ailus@linux.intel.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, xiang@kernel.org, chao@kernel.org, jack@suse.com,
	tytso@mit.edu, adilger.kernel@dilger.ca, dushistov@mail.ru,
	luc.vanoostenryck@gmail.com, rostedt@goodmis.org, pmladek@suse.com,
	sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk, minchan@kernel.org, ngupta@vflare.org,
	akpm@linux-foundation.org, kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de, jmaloy@redhat.com, ying.xue@windriver.com,
	willy@infradead.org, sashal@kernel.org, ruanjinjie@huawei.com,
	David.Laight@aculab.com, herve.codina@bootlin.com, Jason@zx2c4.com,
	keescook@chromium.org, kbusch@kernel.org, bvanassche@acm.org,
	ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-edac@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-mm@kvack.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH v2 00/27 5.10.y] Backport minmax.h updates from v6.17-rc7
Message-ID: <20251017160924.GA2728735@ax162>
References: <20251017090519.46992-1-farbere@amazon.com>
 <2025101704-rumble-chatroom-60b5@gregkh>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025101704-rumble-chatroom-60b5@gregkh>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Oct 17, 2025 at 05:03:02PM +0200, Greg KH wrote:
> On Fri, Oct 17, 2025 at 09:04:52AM +0000, Eliav Farber wrote:
> > This series backports 27 patches to update minmax.h in the 5.10.y
> > branch, aligning it with v6.17-rc7.
> > 
> > The ultimate goal is to synchronize all long-term branches so that they
> > include the full set of minmax.h changes.
> > 
> > - 6.12.y has already been backported; the changes are included in
> >   v6.12.49.
> > - 6.6.y has already been backported; the changes are included in
> >   v6.6.109.
> > - 6.1.y has already been backported; the changes are currently in the
> >   6.1-stable tree.
> > - 5.15.y has already been backported; the changes are currently in the
> >   5.15-stable tree.
> 
> With this series applied, on an arm64 server, building 'allmodconfig', I
> get the following build error.
> 
> Oddly I don't see it on my x86 server, perhaps due to different compiler
> versions?
> 
> Any ideas?
> 
> thanks,
> 
> greg k-h
> 
> ------------------------
> 
> In function ‘rt2800_txpower_to_dev’,
>     inlined from ‘rt2800_config_channel’ at ../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4022:25:
> ./../include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
>   309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> ./../include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
>   290 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> ./../include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
>   309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ../include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>   188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
>       |         ^~~~~~~~~~~~~~~~
> ../include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
>   195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>       |         ^~~~~~~~~~~~
> ../include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
>   218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
>       |                                    ^~~~~~~~~~~~~~~
> ../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
>  3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
>       |                        ^~~~~~~

Missing commit 3bc753c06dd0 ("kbuild: treat char as always unsigned")?

Cheers,
Nathan

