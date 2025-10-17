Return-Path: <linux-erofs+bounces-1258-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7FBBEA590
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Oct 2025 17:58:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp8ct2rwpz3cYV;
	Sat, 18 Oct 2025 02:58:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760716718;
	cv=none; b=g6wX0iasqUbDwPCUhch3LTNuTfy423c9saPxugj76HOtNxhVh5hbduopcbxi8KngU4A2AyPrcyp4ruI6ICbqSNgO0FDZqAukzIHvlVc7SIWH6sD0T4RVHlanNkNRtPH0SRX+r7L22rrXADkhRJKT+DGAexBThcfQkJNt7lHhwpXEav5lm+0vc99BMmKCx5S5l2BqQOc3FP4HC3yiW5NU9OkN/FoI0wryiIt7XAbCbDrd+eDYapVbpVmFTev4lzHAmfaw0S+i34mfkdr48xyCN4+cPxSrakGEzdKC7wXDwoYSygYzK/gpbtPuBveE3wa2n/YzJyIFWywhnNFDEoxZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760716718; c=relaxed/relaxed;
	bh=AdiWHbgl6AHEx4BHfyPyYJgEU9DgWqWz/BaU0smVwgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzLP2Cxg7jaC83nLIfhaxzgbi1f6xNq8l715zOydO0k8r/8BQKYSfoq0AIFpU5YwJJ5C+snW8k24te+7BTSwmCP/6jTH5ITseFLHFmOfy1eXa6JGORKzSOjXh2U8EDiXBx9xlPtmQfk+6bVFXBnTKcHA2uuU9V/u7sVOOopUXjwOExYsJlaJ8piLEzl8FPxWhBzR7PtLOPoL+sEHjmqj4oY1httPtG0IdCHAYQEFdXLCs3dmv6JaxtlWfu5deuy4lEC/fDruI/2KqRq9WG9n79AAM0cGSWrRbyiD3TJbQ/zFmdE0KhbLUG/I4suIQeQoBWXioHZ6fa+D3RnYBnR8CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FLtxIBv7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FLtxIBv7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp8cs1z8nz3cYN
	for <linux-erofs@lists.ozlabs.org>; Sat, 18 Oct 2025 02:58:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DBD064767;
	Fri, 17 Oct 2025 15:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687B5C4CEE7;
	Fri, 17 Oct 2025 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716713;
	bh=20X28MMOWSoptgGAWTUrviJnQniEpl6Ktq66BRGKH/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLtxIBv7SZeCQWvR3ANCLmaMyydymZnc8EmPjl/1wQ2ZU6GZiD2nKCaUbGU/mGLlp
	 fTOdia6A6ekGANEzH++1tbYBhBm/NR7Jy2B8blUuCuIxDXrSTaYf19VuAHrRtgTE73
	 ZyIsy6hsoafgxjCLHqBFDNZjVm7M30+2G2ZqFt0Y=
Date: Fri, 17 Oct 2025 17:03:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: stable@vger.kernel.org, linux@armlinux.org.uk, jdike@addtoit.com,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, tony.luck@intel.com, qiuxu.zhuo@intel.com,
	mchehab@kernel.org, james.morse@arm.com, rric@kernel.org,
	harry.wentland@amd.com, sunpeng.li@amd.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
	james.qian.wang@arm.com, liviu.dudau@arm.com,
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
	keescook@chromium.org, kbusch@kernel.org, nathan@kernel.org,
	bvanassche@acm.org, ndesaulniers@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, linux-edac@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-mm@kvack.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH v2 00/27 5.10.y] Backport minmax.h updates from v6.17-rc7
Message-ID: <2025101704-rumble-chatroom-60b5@gregkh>
References: <20251017090519.46992-1-farbere@amazon.com>
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
In-Reply-To: <20251017090519.46992-1-farbere@amazon.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Oct 17, 2025 at 09:04:52AM +0000, Eliav Farber wrote:
> This series backports 27 patches to update minmax.h in the 5.10.y
> branch, aligning it with v6.17-rc7.
> 
> The ultimate goal is to synchronize all long-term branches so that they
> include the full set of minmax.h changes.
> 
> - 6.12.y has already been backported; the changes are included in
>   v6.12.49.
> - 6.6.y has already been backported; the changes are included in
>   v6.6.109.
> - 6.1.y has already been backported; the changes are currently in the
>   6.1-stable tree.
> - 5.15.y has already been backported; the changes are currently in the
>   5.15-stable tree.

With this series applied, on an arm64 server, building 'allmodconfig', I
get the following build error.

Oddly I don't see it on my x86 server, perhaps due to different compiler
versions?

Any ideas?

thanks,

greg k-h

------------------------

In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at ../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4022:25:
./../include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
./../include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
./../include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
../include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
../include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
../include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at ../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4024:25:
./../include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
./../include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
./../include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
../include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
../include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
../include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at ../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4028:4:
./../include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
./../include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
./../include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
../include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
../include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
../include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
make[6]: *** [../scripts/Makefile.build:286: drivers/net/wireless/ralink/rt2x00/rt2800lib.o] Error 1
make[5]: *** [../scripts/Makefile.build:503: drivers/net/wireless/ralink/rt2x00] Error 2
make[4]: *** [../scripts/Makefile.build:503: drivers/net/wireless/ralink] Error 2
make[4]: *** Waiting for unfinished jobs....

